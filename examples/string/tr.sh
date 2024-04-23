#!/bin/bash
#
# tr - 翻译和删除字符
#
# 删除字符
echo  "删除字符"
echo "abcdefg" | tr -d "bcd"            # Output: aefg
echo "hello" | tr -d 'l'                # Output: heo
echo "hello 123" | tr -d '[:digit:]'    # Output: hello

#
# 翻译字符
echo "翻译字符"
echo "abcdefg" | tr "abc" "123"             # Output: 123defg
echo "hello" | tr 'el' 'xy'                 # Output: hxyyo
echo "abcdefg" | tr 'a-g' 'A-G'             # Output: ABCDEFG
echo abcDefG | tr '[:lower:]' '[:upper:]'   # Output: ABCDEFG
echo abcDefG | tr '[a-z]' '[A-Z]'   # Output: ABCDEFG
echo "hello world" | tr '\n' ','            # Output: hello world,
