#! /usr/bin/env bash

# testing the exit status of a function
func1() {
    echo "trying to display a non-existent file"
    ls -l badfile
}
echo "testing the function: "
func1
echo "The exit status is: $?"


echo "-------------------------------------------------------------------"

# testing the exit status of a function
func1() {
    ls -l badfile
    echo "This was a test of a bad command"
}
echo "testing the function:"
func1
echo "The exit status is: $?"

