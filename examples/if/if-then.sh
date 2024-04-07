#! /usr/bin/env bash
# testing the if statement
if pwd
then
    echo "It worked"
fi
echo "------------------------------------------------------------------"


# testing a bad command
if IamNotaCommand
then
    echo "It worked"
fi
echo "We are outside the if statement"
echo "------------------------------------------------------------------"


# testing multiple commands in the then section
#
testuser=root
#
if grep ${testuser} /etc/passwd
then
    echo "This is my first command"
    echo "This is my second command"
    echo "I can even put in other commands besides echo:"
    ls -a /${testuser}/.b*
fi


