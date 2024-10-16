#! /bin/bash
#
# 通过 kubeadm 快速安装 Kubernetes 集群
#
##################### 系统准备 ############################
#
# 在安全的网络环境下，关闭防火墙服务
#
systemctl disable --now firewalld
#
# 建议在主机上禁用 SELinux
#
sed -i -e 's/^SELINUX=.*$/SELINUX=disabled/' /etc/sysconfig/selinux
#
####################### 基础安装 ##############################
#
# 1. 更新 Centos 7 默认镜像仓库
#
# Centos 7 has reached EOL (End of Life) today, 1 July 2024; 需要镜像源修改
sed -i -e "s/^mirrorlist=http/#mirrorlist=http/" -e "s/^#baseurl=http/baseurl=http/" -e "s/mirror.centos.org/vault.centos.org/" /etc/yum.repos.d/*.repo

yum clean all && yum makecache
#
# 2. 安装 containerd
#
# 加载内核模块
cat <<EOF | tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

modprobe overlay && modprobe br_netfilter
#
# 配置 Docker 镜像仓库; CE: Community Edition， 社区版
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#
# 安装容器运行时 containerd
yum install -y containerd.io
#
# 配置 cgroup 驱动(cgroupDriver) 为 "systemd"
CONTAINDERD_CONFIG_PATH=/etc/containerd/config.toml && \
rm "${CONTAINDERD_CONFIG_PATH}" && \
containerd config default > "${CONTAINDERD_CONFIG_PATH}" && \
sed -i -e "s/SystemdCgroup = false/SystemdCgroup = true/g" \
-e 's#sandbox_image =.*#sandbox_image = "registry.k8s.io/pause:3.9"#' "${CONTAINDERD_CONFIG_PATH}"
#
# 启动 containerd
systemctl enable --now containerd
#
# 3. 安装 kubelet、 kubeadm、kubectl
#
# 配置 Kubernetes 镜像仓库，版本：v1.29
cat > /etc/yum.repos.d/kubernetes.repo <<EOF
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF
#
# 安装 kubelet 包，依赖：conntrack-tools、kubernetes-cni、libnetfilter_cthelper、
#                       libnetfilter_queue、libnetfilter_cttimeout、socat
# 安装 kubeadm 包, 依赖：cri-tools、kubectl；注意：安装 kubeadm 之前，先临时关闭 Linux 系统上的 swap 分区
yum install -y kubelet kubeadm --disableexcludes=kubernetes
#
####################### 安装 Master ###########################
#
# 1. 修改 kubeadm init 的默认配置
#
# 获取默认的 init-defaults 初始化参数文件, 并修改
kubeadm config print init-defaults > init-config.yml

# sed /serviceSubnet:/p init-config.yml -n
sed -i -e "s/advertiseAddress:.*/advertiseAddress: 192.168.56.254/" init-config.yml
sed -i -e "s/name:.*/name: 192.168.56.254/" init-config.yml
sed -i -e "s#serviceSubnet: .*#serviceSubnet: 169.169.0.0/16#" init-config.yml
#
#
# 2. 运行 init pre-flight checks
#
kubeadm init phase preflight --config init-config.yml

swapoff -a

cat >/etc/sysctl.d/k8s.conf <<EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

systemctl enable kubelet
#
# 3. 下载 Kubernetes 相关镜像
#
# 预先下载所需的全部镜像，加快部署
kubeadm config images list
kubeadm config images pull --config=init-config.yml
#
# 4. 通过 kubeadm init 命令安装 Master
#
# 基于之前创建的配置文件一键安装 Master；
# 提示: Your Kubernetes control-plane has initialized successfully!
kubeadm init --config=init-config.yml
#
# 若快速安装失败，可重置，然后再次通过 kubeadm init 命令进行快速安装
kubeadm reset
#
# 5. 测试
#
# 安装 kubectl
yum install -y kubectl --disableexcludes=kubernetes
#
# 为 kubectl 配置客户端的身份配置文件
# --- 方式一：普通用户
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
#
# --- 方式二：Root 用户
export KUBECONFIG=/etc/kubernetes/admin.conf
#
# 测试 kubectl 是否正确连接 Master; 1612111
kubectl -n kube-system get configmap
#
####################### 添加 Node ###########################
#
# 1. 修改 kubeadm join 默认配置
#
# 关注 kubeadm init 命令运行完成后的最后几行提示信息。
kubeadm config print join-defaults > join-config.yml

sed -i -e "s/apiServerEndpoint:.*/apiServerEndpoint: 192.168.56.254:6443/" join-config.yml
sed -i -e "s/name:.*/name: 192.168.56.1/" join-config.yml
#
#
# 1. 执行 join pre-flight checks
#
kubeadm join phase preflight --config join-config.yml

swapoff -a

cat >/etc/sysctl.d/k8s.conf <<EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

systemctl enable kubelet
#
# 1. 将新的 Node 加入集群
#
# 基于上述配置文件，执行命令，将本 Node 加入集群
kubeadm join --config=join-config.yml
#
# 在 Master 上确认新的 Node 已加入集群, 注意，此时 Node 状态均为 NotReady
kubectl get nodes
#
# Master 在默认情况下并不参与工作负载的调度工作
# 如果希望将 Master 配置为 Node，请在 Master Node 上执行以下命令
kubectl taint nodes --all node-role.kubernetes.io/control-plane-node/<advertiseAddress> untainted
#
######################## 安装 CNI 网络插件 ##################################
#
# 1. 在 Master 上安装 CNI 网络插件
#
# 一键安装 Calico CNI 网络插件
kubectl apply -f "https://docs.projectcalico.org/manifests/calico.yaml"
#
# 实时监控 Node 状态，看是否 Ready
kubectl get nodes -w
#
######################## 最终验证 #######################################
#
# 1. 验证 Kubernetes 集群是否正常工作
#
# 查看 Kubernetes 各组件的 Pod 运行状态
kubectl -n kube-system get pods
#
# 调试 Pod
kubectl -n kube-system describe pod <pod_name>
#



#
exit
#