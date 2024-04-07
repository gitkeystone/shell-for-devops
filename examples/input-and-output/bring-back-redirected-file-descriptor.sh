#! /usr/bin/env bash

# storing STDOUT, then coming back to it
#
exec 3>&1
exec 1>test14out
#
echo "This should store in the output file"
echo "along with this line."
#
exec 1>&3
#
echo "Now things should be back to normal"

echo "-------------------------------------------------------------------"

# redirecting input file descriptors
#
exec 6<&0
exec 0< testfile
count=1
#
while read line
do
    echo "Line #$count: $line"
    count=$[ $count + 1 ]
done
#
exec 0<&6
#
read -p "Are you done now? " answer
case ${answer} in
Y|y) echo "Goodbye";;
N|n) echo "Sorry, this is the end.";;
esac
