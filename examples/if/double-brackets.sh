#! /usr/bin/env bash

# using pattern matching
#
# if [[ $USER == r* ]]
if [[ $USER == p* ]]
then
    echo "Hello $USER"
else
    echo "Sorry, I do not know you"
fi




