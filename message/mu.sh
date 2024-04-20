#!/bin/bash
#
# mu.sh - Send a Message to a particular user.(root)
############################################################
#
# Get Opts & Parameters
#
while getopts :u:f:h opt
do
    case "$opt" in
    h)
        #
        # Display Help
        #
        USAGE="
Usage: sudo ./mu.sh OPTION MESSAGE\n
\n
OPTIONS:\n
\t-u <username>\n
\t-h display this help and exit\n
MESSAGE:\n
\t<message_string>\n
\t-f <message_file>
"
        #
        echo -e $USAGE
        exit
        #
    ;;
    u)
        #
        # Save the username parameter
        #
        MUSER=$OPTARG
        #
        # Determine if user is logged on
        #
        LOGGED_ON=$(who -s | grep -i -m 1 $MUSER | gawk '{print $1}')
        #
        if [ -z $LOGGED_ON ]
        then
            echo "$MUSER is not logged on."
            echo "Exiting script..."
            exit
        fi
        #
        # Determine if user allows messaging:
        #
        ALLOWED=$(who -sT | grep -i -m 1 $MUSER | gawk '{print $2}')
        #
        if [ $ALLOWED != "+" ]
        then
            echo "$MUSER does not allowing messaging."
            echo "Exiting script..."
            exit
        fi
        #
    ;;
    f)
        #
        # Save the message file parameter
        #
        MFILE=$OPTARG
        #
        if [ -f $MFILE ]
        then
            WHOLE_MESSAGE=$(cat $MFILE)
        fi
        #
        WHOLE_MESSAGE=$WHOLE_MESSAGE"\n"
        #
    ;;
    *) echo "Unknown option: -$opt" ;;
    esac
done
#
shift $[ $OPTIND - 1 ]
#
# Determine if there is more to the message
#
if [ -n "$*" ]
then
    WHOLE_MESSAGE=$WHOLE_MESSAGE"$*"
fi
#
# Determine if a message was included
#
if [ -z "$WHOLE_MESSAGE" ]
then
    echo "No messages was included."
    echo "Exiting script..."
    exit
fi
#
# Determine if user only logged into GUI
#
UTERMs=$(who -s | grep -i $MUSER | gawk '{print $2}')
#
#
echo $UTERMs | sed -n '/\.*pts\.*/p' > /dev/null
if [[ $? -ne 0 ]]
then
    echo "$LOGGED_ON is currently only logged into the GUI"
    exit
fi
#
# Send message to user
#
for UTERM in $UTERMs
do
    echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n$WHOLE_MESSAGE \n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" |
    write $LOGGED_ON $UTERM
done
#
exit
