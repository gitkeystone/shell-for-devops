#! /usr/bin/env bash

#
#

#
function diskspace {
    clear
    # echo "This is where the diskspace commands will go"
    df -k
}

#
function whoseon {
    clear
    # echo "This is where the who commands will go"
    who
}

#
function memusage {
    clear
    # echo "This is where the memory usage commands will go"
    cat /proc/meminfo
}

#
PS3="Enter option: "
select option in "Display disk space" "Display logged on users" "Display memory usage" "Exit program"
do
    case $option in
    "Exit program")
        break;;
    "Display disk space")
        diskspace;;
    "Display logged on users")
        whoseon;;
    "Display memory usage")
        memusage;;
    *)
        clear
        echo "Sorry, wrong selection";;
    esac
done
clear
