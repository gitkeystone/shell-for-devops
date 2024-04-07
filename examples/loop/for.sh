#! /usr/bin/env bash

# basic for command
for test in Alabama Alaska Arizona Arkansas California Colorado
do
    echo The next state is ${test}
done
echo "The last state we visited was $test"
test=Connecticut
echo "Wait, now we're visiting $test"

echo "------------------------------------------------------------------"

# another example of how not to use the for command
# for test in I don't know if this'll work
for test in I don\'t know if "this'll" work
do
    echo "word:$test"
done

echo "------------------------------------------------------------------"

# another example of how not to use the for command
for test in Nevada "New Hampshire" "New Mexico" "New York" "North Carolina"
do
    echo "Now going to ${test}"
done

echo "------------------------------------------------------------------"

# using a variable to hold the list
list="Alabama Alaska Arizona Arkansas Colorado"
list=${list}" Connecticut"
for state in ${list}
do
    echo "Have you ever visited $state?"
done

echo "------------------------------------------------------------------"

# reading values from a file
file="states"
IFS_OLD=$IFS
IFS=$'\n'
# IFS=:
# IFS=$'\n':;"
for state in $(cat ${file})
do
    echo "Visit beautiful $state"
done
IFS=${IFS_OLD}

echo "------------------------------------------------------------------"

# iterate through all the files in a directory
for file in /home/percxh/101/*
do
    if [ -d "${file}" ]
    then
        echo "${file} is a directory"
    elif [ -f "${file}" ]
    then
        echo "${file} is a {file}"
    fi
done

echo "------------------------------------------------------------------"


# iterating through multiple directories
# 遍历目录中文件，不清楚是否存在，所以，最好先判断文件是否存在
for file in /home/rich/.b* /home/rich/badtest
do
    if [ -d "${file}" ]
    then
        echo "${file} is a directory"
    elif [ -f "${file}" ]
    then
        echo "${file} is a file"
    else
        echo "${file} doesn't exist"
    fi
done