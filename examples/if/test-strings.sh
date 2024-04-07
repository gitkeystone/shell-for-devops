#! /usr/bin/env bash

# =, !=, \<, \>, -n, -z
# -n: 检测字符串长度不为0
# -z: 检测字符串长度为0

# testing string equality
# testuser=rich
testuser=root
#
if [ ${USER} = ${testuser} ]
then
    echo "Welcome, ${testuser}"
fi

# testing string equality
testuser=baduser
#
if [ $USER != $testuser ]
then
    echo "This is not $testuser"
else
    echo "Welcome $testuser"
fi

echo "------------------------------------------------------------------"

# mis-using string comparisons
#
val1=baseball
val2=hockey
#
# if [ $val1 > $val2 ]
if [ $val1 \> $val2 ]
then
    echo "$val1 is greater than $val2"
else
    echo "$val1 is less than $val2"
fi

echo "------------------------------------------------------------------"

# testing string sort order
# test 认为大写字母比较小， ASCII 码排序；
# sort 命令认为小写字母比较小
val1=Testing
val2=testing
#
if [ $val1 \> $val2 ]
then
    echo "$val1 is greater than $val2"
else
    echo "$val1 is less than $val2"
fi

echo "------------------------------------------------------------------"

# testing string length
val1=testing
val2=''
#
if [ -n ${val1} ]
then
    echo "The string '${val1}' is not empty"
else
    echo "The string '${val1}' is empty"
fi
#
if [ -z ${val2} ]
then
    echo "The string '${val2}' is empty"
else
    echo "The string '${val2}' is not empty"
fi
#
if [ -z ${val3} ]
then
    echo "The string '${val3}' is empty"
else
    echo "The string '${val3}' is not empty"
fi
