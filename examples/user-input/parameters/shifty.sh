#! /usr/bin/env bash

# demonstrating the shift command
# echo
# count=1
# while [ -n "$1" ]
# do
#     echo "Parameter #${count} = $1"
#     count=$[ ${count} + 1 ]
#     shift
# done


# demonstrating a multi-position shift
#
echo
echo "The original parameters: $*"
shift 2
echo "Here's the new first parameter: $1"