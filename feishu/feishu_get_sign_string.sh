#!/bin/bash
#
# 飞书自定义机器人安全设置：签名校验
# https://www.xmodulo.com/embed-binary-file-bash-script.html
#
##################################################
# Extract HMAC_SHA256 From this script file
##################################################
# Line number where payload starts
PAYLOAD_LINE=$(awk '/^__PAYLOAD_BEGINS__/ { print NR + 1; exit 0; }' $0)

echo $PAYLOAD_LINE
# Directory where a binary executable is to be saved
BIN_DIR=/tmp

# Name of an embedded binary executable
BIN_NAME=HMAC_SHA256

# Extract the embedded binary executable
rm -f $BIN_DIR/$BIN_NAME
tail -n +$PAYLOAD_LINE  | base64 -d > $BIN_DIR/$BIN_NAME

##################################################
# Print Feishu Signature
##################################################
# Define your secret key
SECRET_KEY="m2UVmYp7p1kzWmAzYQSE0b"

# Get the current timestamp
TIMESTAMP=$(date +%s)
# TIMESTAMP="1714061714"

# Construct the signing string
SIGNING_STRING="${TIMESTAMP}"$'\n'"${SECRET_KEY}"

# Calculate HMAC with SHA256
# Yk1t9H5OJ67WEiMcsKbTfAwwvZUSKFtWd3HBR4qrD+A=
SIGNATURE=$($BIN_DIR/$BIN_NAME --stringToSign $SIGNING_STRING)

# Result
echo "Timestamp: $TIMESTAMP"
echo "Signature: $SIGNATURE"


exit 0
# base64 HMAC_SHA256 >> feishu_get_sign_string.sh
__PAYLOAD_BEGINS__
