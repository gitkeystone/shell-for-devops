#!/bin/bash
#
# string parameter expansion:
#       allow the string stored in a variable to be manipulated
#
URL="2024-04-20 13:53:00 URL: http://www.quotationspage.com/error404.html 200 OK"
#
# Search - Using wildcars; 如果搜索成功，则返回 'error404'; 否则，原样返回；sed 替代品；
#
echo ${URL/*error404*/error404}
#
# Extract substring
#
echo ${URL:0:10}
#
exit
