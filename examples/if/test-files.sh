#！/usr/bin/env bash

# -d, -e, -f, -r, -s, -w, -x, -O, -G, -nt, -ot
# -s: 文件非空，有数据

# Look before you leap
#
jump_directory=/home/arthur
#
# 因为 路径中可能存在空格，最好把路径变量用双引号包起来
if [ -d "${jump_directory}" ]
then
    echo "The ${jump_directory} directory exists"
    cd ${jump_directory}
    ls
else
    echo "The ${jump_directory} directory does not exist"
fi
#

echo "------------------------------------------------------------------"
# Check if either a directory or file exists
#
location=$HOME
file_name="sentinel"
#
if [ -e ${location} ]
then #Directory does exist
    echo "OK on the ${location} directory."
    echo "Now checking on the file, ${file_name}."
    #
    if [ -e ${location}/${file_name} ]
    then #File does exist
        echo "OK on the filename"
        echo "Updating Current Date..."
        date >> ${location}/${file_name}
    #
    else #File does not exist
        echo "File does not exist"
        echo "Nothing to update"
    fi
#
else #Directory does not exist
    echo "The ${location} directory does not exist."
    echo "Nothing to update"
fi

echo "------------------------------------------------------------------"

# Check if either a directory or file exists
#
# item_name=${HOME}
item_name=${HOME}/sentinel
echo
echo "The item being checked: ${item_name}"
echo
#
if [ -e ${item_name} ]
then #Item does exist
    echo "The item, ${item_name}, does exist."
    echo "But is it a file?"
    echo
    #
    if [ -f ${item_name} ]
    then #Item is a file
        echo "Yes, ${item_name} is a file."
    #
    else #Item is not a file
        echo "No, ${item_name} is not a file."
    fi
#
else #Item does not exist
    echo "The item, ${item_name}, does not exist."
    echo "Nothing to update"
fi
#

echo "------------------------------------------------------------------"

# testing if you can read a file
pwfile=/etc/shadow
#
# first, test if the file exists, and is a file
if [ -f $pwfile ]
then
    # now test if you can read it
    if [ -r $pwfile ]
    then
        tail $pwfile
    else
        echo "Sorry, I am unable to read the $pwfile file"
    fi
else
    echo "Sorry, the file $file does not exist"
fi

echo "------------------------------------------------------------------"

# Testing if a file is empty
#
file_name=${HOME}/sentinel
#
if [ -f ${file_name} ]
then
    if [ -s ${file_name} ]
    then
        echo "The ${file_name} file exists and has data in it."
        echo "Will not remove this file."
    #
    else
        echo "The ${file_name} file exists, but is empty."
        echo "Deleting empty file..."
        rm ${file_name}
    fi
else
    echo "File, ${file_name}, does not exist."
fi
#

echo "------------------------------------------------------------------"


# Check if a file is writable.
#
item_name=$HOME/sentinel
echo
echo "The item being checked: ${item_name}"
echo
#
if [ -f ${item_name} ]
then #Item does exist
    echo "Yes, ${item_name} is a file."
    echo "But is it writable?"
    echo
    #
    if [ -w ${item_name} ]
    then #Item is writable
        echo "Writing current time to ${item_name}"
        date +%H%M >> ${item_name}
    #
    else #Item is not writable
        echo "Unable to write to ${item_name}"
    fi
    #
else #Item is not a file
    echo "No, $item_name is not a file."
fi

echo "------------------------------------------------------------------"

# testing file execution
#
if [ -x test16.sh ]
# if [ -x test.sh ]
then
    echo "You can run the script: "
    ./test16.sh
else
    echo "Sorry, you are unable to execute the script"
fi

echo "------------------------------------------------------------------"

# check file ownership
#
if [ -O /etc/passwd ]
then
    echo "You are the owner of the /etc/passwd file"
else
    echo "Sorry, you are not the owner of the /etc/passwd file"
fi

echo "------------------------------------------------------------------"

# check file group test
# 仅比较默认组
#
if [ -G $HOME/testing ]
then
    echo "You are in the same group as the file"
else
    echo "The file is not owned by your group"
fi

echo "------------------------------------------------------------------"

# testing file dates
#
if [ test.sh -nt math.sh ]
then
    echo "The test.sh file is newer than math.sh"
else
    echo "The math.sh file is newer than test.sh"
fi

if [ test17.sh -ot test19.sh ]
then
    echo "The test17 file is older than the test19 file"
fi

# testing file dates
# 默认不判断文件是否存在， 所以在使用 -nt, -ot 时，需要先判断文件是否存在
#
if [ badfile1 -nt badfile2 ]
then
    echo "The badfile1 file is newer than badfile2"
else
    echo "The badfile2 file is newer than badfile1"
fi