#!/bin/bash
#
# Hourly_Archive - Every hour create an archive
########################################################
#
# Set Configuration File
#
CONFIG_FILE=/archive/hourly/Files_To_Backup
#
# Set Base Archive Destination Location
#
BASEDEST=/archive/hourly
#
# Gather Current Day, Month & Time
#
DAY=$(date +%d)
MONTH=$(date +%m)
TIME=$(date +%H%M)
#
# Create Archive Destination Directory
#
mkdir -p $BASEDEST/$MONTH/$DAY
#
# Build Archive Destination File Name
#
DESTINATION=$BASEDEST/$MONTH/$DAY/archive$TIME.tar.gz
#
########## Main Script #################################
#
# Check Backup Config file exists
#
if [ -f $CONFIG_FILE ]  # Make sure the config file still exists.
then                # If it exists, do nothing but continue on.
    echo
else                # If it doesn't exist, issue error & exit script.
    echo
    echo "$CONFIG_FILE does not exist."
    echo "Backup not completed due to missing Configuration File."
    echo
    exit
fi
#
# Build the names of all the files to backup
#
FILE_NO=1                           # Start on Line 1 of Config File.
exec < $CONFIG_FILE                 # Redirect Std Input to name of Config File.
#
read FILE_NAME                      # Read 1st record.
#
while [ $? -eq 0 ]
do
    # Make sure the file or directory exists.
    if [ -f $FILE_NAME -o -d $FILE_NAME ]
    then
        # If file exists, add its name to the list.
        FILE_LIST="$FILE_LIST $FILE_NAME"
    else
        # If file doesn't exist, issue warning.
        echo
        echo "$FILE_NAME does not exist."
        echo "Obviously, I will not include it in this archive."
        echo "It is listed on line $FILE_NO of the config file."
        echo "Continuing to build archive list ..."
        echo
    fi
#
    FILE_NO=$[ $FILE_NO + 1 ]           # Increment Line/File number by one.
    read FILE_NAME                      # Read next record.
done
#
##########################################
#
# Backup the files and Compress Archive
#
echo "Starting archive..."
echo
#
tar -czf $DESTINATION $FILE_LIST 2>/dev/null
#
echo "Archive completed"
echo "Resulting archive file is: $DESTINATION"
echo
#
exit
