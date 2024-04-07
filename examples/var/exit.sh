#! /usr/bin/env bash
# Code  Description
# 0     Successful completion of the command
# 1     General unknown error
# 2     Misuse of shell command
# 126   The command can’t execute
# 127   Command not found
# 128   Invalid exit argument
# 128+x Fatal error with Linux signal x
# 130   Command terminated with Ctrl+C
# 255   Exit status out of range


# exit 1

# var1=40
var1=300
exit ${var1}

# echo $?