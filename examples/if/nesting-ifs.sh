#! /usr/bin/env bash

# Testing nested ifs
#
testuser=NoSuchUser
#
if grep ${testuser} /etc/passwd
then
    echo "The user $testuser exists on this system."
else
    echo "The user $testuser does not exist on this system."
    if ls -d /home/${testuser}
    then
        echo "However, ${testuser} has a directory."
    fi
fi

echo "--------------------------------------------------------------------"


# Testing nested ifs - use elif
#
testuser=NoSuchUser
#
if grep $testuser /etc/passwd
then
    echo "The user $testuser exists on this system."
#
elif ls -d /home/$testuser
then
    echo "The user $testuser does not exist on this system."
    echo "However, $testuser has a directory."
#
else
    echo "The user $testuser does not exist on this system."
    echo "And, $testuser does not have a directory."
fi