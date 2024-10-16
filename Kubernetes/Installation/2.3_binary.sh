#! /bin/bash
#
# 基于 Kubernetes v1.29，通过二进制文件，配置、部署一个启用了安全机制且有 3 个节点的高可用 Kubernetes 集群。
#
##################### 系统要求 ############################
#
# 在安全的网络环境下，可以关闭防火墙服务
#
systemctl disable firewalld
systemctl stop firewalld
#
# 建议在主机上禁用 SELinux
#
sed -i -e 's/^SELINUX=.*$/SELINUX=disabled/' /etc/sysconfig/selinux
#
################### 创建 CA 根证书 #################
#
# 1. 通过可信任的 CA 中心获取证书
#
# 2. 自行制作 CA 证书（OpenSSL、easyrsa、CFSSL）
#
# 私钥：ca.key; 证书（公钥）：ca.crt; pki: Public Key Infrastructure, 公钥基础设施
mkdir -p /etc/kubernetes/pki
cd /etc/kubernetes/pki
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -subj "/CN=192.168.18.3" -days 36500 -out ca.crt
#
################### 部署安全的 etcd 高可用集群 ##########
#
# 下载二进制文件
curl -LOj https://
# 解压缩到 /usr/bin/
tar -xf etcd-v3.4.27-linux-amd64.tar.gz -C /usr/bin/
#
# 创建 systemd 服务配置文件
cat >/usr/lib/systemd/system/etcd.service <<EOF
[Unit]
Description=etcd key-value store
Documentation=https://github.com/etcd-io/etcd
After=network.target

[Service]
EnvironmentFile=/etc/etcd/etcd.conf
ExecStart=/usr/bin/etcd
Restart=always

[Install]
WantedBy=multi-user.target
EOF
#
# 创建一个 x509 v3 配置文件
# alt_names 包括所有 etcd 主机的 IP 地址
cat >/etc/etcd/pki/etcd_ssl.conf <<EOF
[ req ]
req_extensions = v3_req
distinguished_name = req_distinguished_name

[ req_distinguished_name ]

[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[ alt_names ]
IP.1 = 192.168.18.3
IP.2 = 192.168.18.4
IP.3 = 192.168.18.5
EOF

