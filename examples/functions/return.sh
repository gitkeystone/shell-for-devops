#!/bin/bash
#
# using the return command in a function
#
function dbl {
    read -p "Enter a value: " value
    echo "doubling the value"
    return $[ $value * 2 ] # return the num
}
dbl
echo "The new value is $?"

