#! /usr/bin/env bash

# testing STDERR messages
#
echo "This is an error" >&2
echo "This is normal output"
#
# ./purposely-generate-error-messages.sh 2> test9
#