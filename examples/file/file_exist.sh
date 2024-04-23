#!/bin/bash

function if_file_exist () {
    if [ $# -ne 1 ];then
        echo "请输入要检测的文件名"
        return 1;
    else
        #开始检测文件是否存在
        if [ -f $1 ];then
            return 0;
        else
            return 1
        fi
        #
    fi
}

if_file_exist