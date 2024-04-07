#! /usr/bin/env bash

#
# testing closing file descriptors
#
# exec 3> test17file
# echo "This is a test line of data" >&3
# exec 3>&-
# echo "This won't work" >&3

#
# testing closing file descriptors, and then reopening
#
exec 3> testfile
echo "This is a test line of data" >&3
exec 3>&-
cat testfile
exec 3> testfile
echo "This'll be bad" >&3
