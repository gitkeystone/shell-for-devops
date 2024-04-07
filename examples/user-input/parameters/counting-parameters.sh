#! /usr/bin/env bash

# $#
# getting the number of parameters
#
echo There were $# parameters supplied.

echo "------------------------------------------------------------------"

# Testing parameters
#
if [ $# -ne 2 ]
then
    echo
    echo Usage: test9.sh a b
    echo
else
    total=$[ $1 + $2 ]
    echo
    echo The total is $total
    echo
fi

echo "------------------------------------------------------------------"

#!/bin/bash
# testing grabbing last parameter
#
# error
echo The last parameter was ${$#}

echo "------------------------------------------------------------------"

# Grabbing the last parameter
#
echo
echo The last parameter is ${!#}
echo
