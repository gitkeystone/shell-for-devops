#! /usr/bin/env bash

# using the continue command
for (( var1 = 1; var1 < 15; var1++ ))
do
    if [ $var1 -gt 5 ] && [ $var1 -lt 10 ]
    then
        continue
    fi
    echo "Iteration number: $var1"
done


echo "------------------------------------------------------------------"

# improperly using the continue command in a while loop
var1=0
while echo "while iteration: $var1"
    [ $var1 -lt 15 ]
do
    if [ $var1 -gt 5 ] && [ $var1 -lt 10 ]
    then
        # continue
        echo
    fi
    echo " Inside iteration number: $var1"
    var1=$[ $var1 + 1 ]
done

echo "------------------------------------------------------------------"

# continuing an outer loop
for (( a = 1; a <= 5; a++ ))
do
    echo "Iteration $a:"
    for (( b = 1; b < 3; b++ ))
    do
        if [ $a -gt 2 ] && [ $a -lt 4 ]
        then
            continue 2
        fi
        var3=$[ $a * $b ]
        echo " The result of $a * $b is $var3"
    done
done




