#!/bin/bash
#
# Feishu - 调用自定义机器人的 Webhook 地址，向所在群组发送卡片
#
##################################################
# Main Script
##################################################
#
# Configuration - Feishu Bot Webhook & Signature & Card
# TODO: If need, change $Webhook_URL, $CHECKSUM, $CARD
#
Webhook_URL="https://open.feishu.cn/open-apis/bot/v2/hook/ef8d8610-7ab9-4db5-99f4-edfe815096ef"
CHECKSUM="m2UVmYp7p1kzWmAzYQSE0b"

# Card Template Infomation
TEMPLATE_ID="AAqkIBzWJpFDj"
TEMPLATE_VERSION_NAME="1.0.0"


#
# Send Card
#
function send_card {
    # Feishu Bot Webhook & Signature
    local Webhook_URL=$1
    local CHECKSUM=$2

    # Card ID & Version
    local TEMPLATE_ID=$3
    local TEMPLATE_VERSION_NAME=$4

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
            "msg_type":"interactive",
            "card":{
                "type": "template",
                "data": {
                    "template_id": "'${TEMPLATE_ID}'",
                    "template_version_name": "'${TEMPLATE_VERSION_NAME}'",
                    "template_variable": {
                        "summary_ticket": "10",
                        "summary_hours": "10",
                        "summary_pending": "20%",
                        "object_list_1": [
                            {
                            "name": "王冰",
                            "duration": "小于1小时",
                            "diff": "↓12%",
                            "diff_color": "green"
                            },
                            {
                            "name": "王芳",
                            "duration": "2小时",
                            "diff": "↑5%",
                            "diff_color": "red"
                            },
                            {
                            "name": "张敏",
                            "duration": "3小时",
                            "diff": "↓25%",
                            "diff_color": "green"
                            }
                        ]
                    }
                }
            }
        }'
}

# Send card
send_card "$Webhook_URL" "$CHECKSUM" "$TEMPLATE_ID" "$TEMPLATE_VERSION_NAME"


#
exit 0


