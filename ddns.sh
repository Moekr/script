#!/bin/sh

EMAIL="email@example.com"
TOKEN="token"
DOMAIN="example.com"
RECORD="www"
RECORD_TYPE="A"
RECORD_NAME="${RECORD}.${DOMAIN}"

date
echo "Domain: ${DOMAIN}, Record type: ${RECORD_TYPE}, Record name: ${RECORD_NAME}"
echo "Begin ddns update."
RECORD_CONTENT=$(/sbin/ifconfig | grep 'inet addr' | grep -v '127.0.0' | awk '{print $2}' | awk -F: '{print $2}')
echo "Current IP: ${RECORD_CONTENT}"
DOMAIN_ID=$(curl --insecure -X GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}" -H "X-Auth-Email: ${EMAIL}" -H "X-Auth-Key: ${TOKEN}" 2>/dev/null | awk -F\" '{print $6}')
RECORD_ID=$(curl --insecure -X GET "https://api.cloudflare.com/client/v4/zones/${DOMAIN_ID}/dns_records?type=${RECORD_TYPE}&name=${RECORD_NAME}" -H "X-Auth-Email: ${EMAIL}" -H "X-Auth-Key: ${TOKEN}" 2>/dev/null | awk -F\" '{print $6}')
curl --insecure -X PUT "https://api.cloudflare.com/client/v4/zones/${DOMAIN_ID}/dns_records/${RECORD_ID}" -H "X-Auth-Email: ${EMAIL}" -H "X-Auth-Key: ${TOKEN}" -H "Content-Type: application/json" --data '{"type":"'${RECORD_TYPE}'","name":"'${RECORD_NAME}'","content":"'${RECORD_CONTENT}'"}' >/dev/null 2>&1
echo "Update done."
