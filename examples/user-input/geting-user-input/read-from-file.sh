#! /usr/bin/env bash

# reading data from a file
#
input="read.sh"
#
count=1
cat ${input} |while read line
do
    echo "Line $count: $line"
    count=$[ $count + 1 ]
done
