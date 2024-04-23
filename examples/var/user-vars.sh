#! /usr/bin/env bash
# testing variables
days=10
guest="Katie"
echo "${guest} checked in ${days} days ago"
days=5
guest="Jessica"
echo "${guest} checked in ${days} days ago"

# assigning a variable value to another variable
value1=10
value2=${value1}
echo The resulting value is ${value2}