#! /usr/bin/env bash

# while command test
var1=10
while [ ${var1} -gt 0 ]
do
    echo ${var1}
    var1=$[ ${var1} - 1 ]
done

echo "------------------------------------------------------------------"

# testing a multicommand while loop
var1=10
while echo $var1
        [ $var1 -ge 0 ]
do
    echo "This is inside the loop"
    var1=$[ $var1 - 1 ]
done

