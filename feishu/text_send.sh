#!/bin/bash
#
# Feishu - 调用自定义机器人的 Webhook 地址，委托 机器人 向所在群组发送 text
#
##################################################
# Main Script
##################################################
#
# Configuration - Feishu Bot Webhook & Signature & TEXT
# TODO: If need, change $Webhook_URL, $CHECKSUM, $TEXT
#
Webhook_URL="https://open.feishu.cn/open-apis/bot/v2/hook/ef8d8610-7ab9-4db5-99f4-edfe815096ef"
CHECKSUM="m2UVmYp7p1kzWmAzYQSE0b"

# Get Usage of Disk Space mounted on /
DISKSPACE=$(df -h |grep /$ | awk '{print $5}')
# Send Text
TEXT="磁盘空间预警: "${DISKSPACE}

#
# Send Text
#
function send_text {
    # Feishu Bot Webhook & Signature
    local Webhook_URL=$1
    local CHECKSUM=$2

    # Text to send
    local TEXT=$3

    #
    # Calculate HMAC with SHA256
    #
    # Get the current timestamp
    local TIMESTAMP=$(date +%s)
    #
    # Construct the HMAC key string
    local HMAC_KEY=${TIMESTAMP}$'\n'${CHECKSUM}
    #
    local SIGNATURE=$(echo -n "" | openssl mac -digest SHA256 -macopt key:"$HMAC_KEY" -binary HMAC | base64 )

    # curl
    curl -X POST -H "Content-Type: application/json" $1 \
        --data '{
            "timestamp":"'${TIMESTAMP}'",
            "sign":"'${SIGNATURE}'",
            "msg_type":"text",
            "content":{
                "text":"'"${TEXT}}"'"
            }
        }'
}

# Send text
send_text "$Webhook_URL" "$CHECKSUM" "$TEXT"


#
exit 0


