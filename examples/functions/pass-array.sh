#! /usr/bin/env bash

# array variable to function test
function testit {
    local newarray
    newarray=(`echo "$@"`)
    echo "The new array value is: ${newarray[*]}"
}
myarray=(1 2 3 4 5)
echo "The original array is ${myarray[*]}"
testit ${myarray[*]}

echo "-------------------------------------------------------------------"

# adding values in an array
function addarray {
    local sum=0
    local newarray
    newarray=($(echo "$@"))
    for value in ${newarray[*]}
    do
    sum=$[ $sum + $value ]
    done
    echo $sum
}
myarray=(1 2 3 4 5)
echo "The original array is: ${myarray[*]}"
#
arg1=$(echo ${myarray[*]})
result=$(addarray $arg1)
#
echo "The result is $result"




