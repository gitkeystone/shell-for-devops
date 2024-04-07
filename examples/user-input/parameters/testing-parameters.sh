#! /usr/bin/env bash

# testing parameters before use
#
# if [ -n "$1" ]
# if test $1
if [ $1 ]
then
    echo Hello $1, glad to meet you.
else
    echo "Sorry, you did not identify yourself. "
fi