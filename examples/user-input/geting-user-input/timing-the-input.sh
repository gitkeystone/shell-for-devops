#! /usr/bin/env bash


# Testing the REPLY Environment variable
#
# read -p "Enter your name: "
# echo
# echo Hello $REPLY, welcome to my program.
#

# timing the data entry
#
if read -t 5 -p "Please enter your name: " name
then
    echo "Hello $name, welcome to my script"
else
    echo
    echo "Sorry, too slow! "
fi
#