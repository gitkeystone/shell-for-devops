#! /usr/bin/env bash

# $* - 把所有的参数作为一个字符串来处理， 一个大的字符串对象；
# $@ - 把所有的参数作为一个字符串数组来处理， 一个数组对象；  经常和 for
# $* 和 $@ 的区别
# 不带引号时，$* 和 ￥@ 没有区别
# 带引号时， "$*" 和 "$@" 有区别， 前面是一个字符串， 后面是一个字符串数组；


#!/bin/bash
# testing $* and $@
#
echo
echo "Using the \$* method: $*"
echo
echo "Using the \$@ method: $@"

echo "------------------------------------------------------------------"

# testing $* and $@
#
echo
count=1
#
for param in "$*"
do
    echo "\$* Parameter #$count = $param"
    count=$[ $count + 1 ]
done
#
echo
count=1
#
for param in "$@"
do
    echo "\$@ Parameter #$count = $param"
    count=$[ $count + 1 ]
done