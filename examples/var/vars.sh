#! /usr/bin/env bash

# 变量名：不超过20字符的数字、字母、下划线，不能以数字开头

# adding text to the end of an existing text string stored in a variable
list="Alabama Alaska Arizona Arkansas Colorado"
list=$list" Connecticut"

echo ${list}