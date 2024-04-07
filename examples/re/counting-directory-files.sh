#! /usr/bin/env bash

# count number of files in your PATH
mypath=$(echo $PATH | sed 's/:/ /g')
#
for directory in $mypath
do
    if ! [ -d $directory ]
    then
        continue
    fi

    count=0
    for _ in $directory/*
    do
        count=$((count+1))
    done
    echo "$directory - $count"
done
