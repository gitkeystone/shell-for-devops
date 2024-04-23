#!/bin/bash
#
# Make sure the variable's value is that you want
#
#############################################
function yes_or_no () {
    read -e y_o_n
    #转换为大写
    y_o_n=$(echo $y_o_n | tr [a-z] [A-Z])
    #
    while [ "$y_o_n" != "Y" -a "$y_o_n" != "N" ]
    do
        echo "请正确输入(y or n),不区分大小写"
        read -e y_o_n
        #转换为大写
        y_o_n=$(echo $y_o_n | tr [a-z] [A-Z])
    done
    #
    if [ "$y_o_n" = "Y" ];then
            return 0
    else
        return 1
    fi
} # End of yes_or_no function
#
############################################
function input_mk_sure() {
	if [ "$1"X = "X" ]; then
        echo "Paramter of input_mk_sure invalid!"
		exit 1
    fi

    cmd="echo \$$1"
    __var_value__=`eval $cmd`

    echo "您输入的是$__var_value__,确定吗?(y/n)"
    yes_or_no
    while [ $? -ne 0 ]
    do
        echo "请重新输入"
        read -e __var_value__
        echo "您输入的是$__var_value__,确定吗?(y/n)"
        yes_or_no
    done

    # 变量重新赋值
    cmd="$1=\$__var_value__"
    eval $cmd

    return 0
} # End of input_mk_sure function
#########################################################
#
# Declare variable
var1="hello"
input_mk_sure var1
#
