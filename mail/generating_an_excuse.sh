#!/bin/bash
#
# Send a Text Message
###################################
#
# Script Variables ###
#
phone="13120312345"
SMSrelay_url="http://textbelt.com/text"
text_message="System Code Red"
#
# Send the message ###
#
curl -s -X POST $SMSrelay_url \
--data-urlencode "number=$phone" \
--data-urlencode "message=$text_message" > /dev/null
#
exit
