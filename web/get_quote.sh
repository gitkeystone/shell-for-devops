#!/bin/bash
#
# Get a Daily Inspirational Quote
#########################################################
#
# Script Variables ###
#
QUOTE_URL="www.quotationspage.com/qotd.html"
#
# Check url validity ###
#
CHECK_URL=$(wget -nv --spider $QUOTE_URL 2>&1)
#
if [[ $CHECK_URL == *"error404"* ]]
then
    echo "Bad web address"
    echo "$QUOTE_URL invalid"
    echo "Exiting script..."
    exit
fi
#
# Download Web Site's Information ###
#
TEMPLOG=$(mktemp -t quote.log.XXXXXXXXXXX)
TEMPHTML=$(mktemp -t quote.html.XXXXXXXXXXX)
#
wget -o $TEMPLOG -O $TEMPHTML $QUOTE_URL
#
# Extract the desired Data
#
# sed -n '/Selected from/{N ; s/<[^>]*>//g; s/>//g; s/&nbsp;//g; p}' $TEMPHTML |
# tee /tmp/daily_quote.txt > /dev/null
#
sed 's/<[^>]*>//g' $TEMPHTML |
grep "$(date +%B' '%-d,' '%Y)" -A2 |
sed 's/>//g' |
sed '/&nbsp;/{n ; d}' |
gawk 'BEGIN{FS="&nbsp;"} {print $1}' |
tee /tmp/daily_quote.txt > /dev/null
#
# Clean up
#
rm -f $TEMPLOG $TEMPHTML
#
exit




