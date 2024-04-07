#! /usr/bin/env bash

# testing the C-style for loop
for (( i=1; i <= 10; i++ ))
do
    echo "The next number is $i"
done
echo The last number is ${i}

echo "------------------------------------------------------------------"

# multiple variables
for (( a=1, b=10; a <= 10; a++, b-- ))
do
    echo "$a - $b"
done