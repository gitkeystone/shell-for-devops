#!/bin/bash
#
# 飞书自定义机器人安全设置：签名校验
#
##################################################
# Print Feishu Signature
##################################################
# Get the current timestamp
TIMESTAMP=$(date +%s)
TIMESTAMP="1714061714"

# Using the checksum from feishu's robot
CHECKSUM="m2UVmYp7p1kzWmAzYQSE0b"

# Construct the HMAC key string
HMAC_KEY="${TIMESTAMP}"$'\n'"${CHECKSUM}"

# Calculate HMAC with SHA256
# SIGNATURE=$(echo -n "" | openssl dgst -sha256 -hmac "$HMAC_KEY" -binary | base64 )
SIGNATURE=$(echo -n "" | openssl mac -digest SHA256 -macopt key:"$HMAC_KEY" -binary HMAC | base64 )

# Result
echo "Timestamp: $TIMESTAMP"
echo "Signature: $SIGNATURE"
echo "Target   : Yk1t9H5OJ67WEiMcsKbTfAwwvZUSKFtWd3HBR4qrD+A="

