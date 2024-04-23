#! /usr/bin/env bash

# returning an array value
function arraydblr {
    local origarray
    local newarray
    local elements
    local i
    origarray=($(echo "$@"))
    newarray=($(echo "$@"))
    elements=$[ $# - 1 ]
    for (( i = 0; i <= $elements; i++ ))
    {
        newarray[$i]=$[ ${origarray[$i]} * 2 ]
    }
    echo ${newarray[*]}         # 输出数组列表元素
}
myarray=(1 2 3 4 5)
echo "The original array is: ${myarray[*]}"
#
arg1=$(echo ${myarray[*]})
result=($(arraydblr $arg1)) # ()用于构建数组
#
echo "The new array is: ${result[*]}"
