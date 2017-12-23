#!/bin/bash

INTERVAL=5
DECIMAL=100
SUFFIX=("Byte" "KiB" "MiB" "GiB")

function cal_speed(){
	INDEX=0
	VALUE=$(expr $1 \* ${DECIMAL})
	VALUE=$(expr ${VALUE} / ${INTERVAL})
	while [ ${VALUE} -gt 102400 ]
	do
		VALUE=$(expr ${VALUE} / 1024)
		INDEX=$(expr ${INDEX} + 1)
	done
	echo $(expr ${VALUE} / ${DECIMAL}).$(expr ${VALUE} % ${DECIMAL}) ${SUFFIX[${INDEX}]}/s
}

ifconfig $1 > /dev/null || exit 1
ORIGIN=$(ifconfig eth1 | grep 'RX bytes' | awk '{print $2":"$6}' | awk -F : '{print $2" "$4}')
ORIGIN_RX=$(echo ${ORIGIN} | awk '{print $1}')
ORIGIN_TX=$(echo ${ORIGIN} | awk '{print $2}')
sleep ${INTERVAL}
CURRENT=$(ifconfig eth1 | grep 'RX bytes' | awk '{print $2":"$6}' | awk -F : '{print $2" "$4}')
CURRENT_RX=$(echo ${CURRENT} | awk '{print $1}')
CURRENT_TX=$(echo ${CURRENT} | awk '{print $2}')
DELTA_RX=$(expr ${CURRENT_RX} - ${ORIGIN_RX})
DELTA_TX=$(expr ${CURRENT_TX} - ${ORIGIN_TX})
echo -n "RX: "
cal_speed ${DELTA_RX}
echo -n "TX: "
cal_speed ${DELTA_TX}
