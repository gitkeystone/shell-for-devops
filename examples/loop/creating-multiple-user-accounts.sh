#! /usr/bin/env bash

# process new user accounts
#
IFS_OLD=${IFS}
#
input="users.csv"           # the users.csv file's end must have a new line;
IFS=','
while read -r userid name   # The `read` command does the work of moving onto the next line of text
do
    echo "adding ${userid}"
    # useradd -c "${name}" -m "${userid}"
done < "${input}"


#
IFS=${IFS_OLD}