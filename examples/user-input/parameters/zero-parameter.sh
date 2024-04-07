#! /usr/bin/env bash

# Testing the $0 parameter
#
# echo The zero parameter is set to: $0

# Using basename with the $0 parameter
#
# name=$(basename $0)
# echo
# echo The script name is: $name

# Testing a Multi-function script
#
name=$(basename $0)
#
if [ $name = "addem" ]
then
    total=$[ $1 + $2 ]
#
elif [ $name = "multem" ]
then
    total=$[ $1 * $2 ]
fi
#
echo
echo The calculated value is $total

