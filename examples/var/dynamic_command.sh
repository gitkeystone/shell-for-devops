#!/bin/bash
#
# Dynamic command - eval "command or expression"
#
# Create a variable
#
cmdlets="var1=100"
eval $cmdlets
echo $var1
#
# execute a command
cmdlets="echo Hello, world!"
eval "$cmdlets"
#
exit
