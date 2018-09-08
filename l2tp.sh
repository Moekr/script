#!/bin/sh

VPN="vpn"
IFACE=$(/sbin/ifconfig | grep ppp0)
#echo "IFACE = ${IFACE}"

if [ -z "${IFACE}" ]
then
    echo "Connect to ${VPN}..."
    echo "c ${VPN}" > /var/run/xl2tpd/l2tp-control
    sleep 10
    IFACE=$(/sbin/ifconfig | grep ppp0)
    #echo "IFACE = ${IFACE}"
    if [ -z "${IFACE}" ]
    then
        echo "Connect failed, exit..."
        exit 1
    fi
    echo "Connect success, add route table..."
    /sbin/route add -net 172.16.0.0 netmask 255.240.0.0 dev ppp0
    /sbin/route add -net 114.212.0.0 netmask 255.255.0.0 dev ppp0
    /sbin/route add -net 202.119.32.0 netmask 255.255.224.0 dev ppp0
    /sbin/route add -net 210.28.128.0 netmask 255.255.240.0 dev ppp0
    /sbin/route add -net 219.219.112.0 netmask 255.255.240.0 dev ppp0
    echo "Add route table success, exit..."
    exit 0
fi
echo "Connection already exist, exit..."
