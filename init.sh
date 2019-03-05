#!/bin/bash

apt update && apt upgrade -y && apt autoremove -y
apt install -y iptables-persistent
apt install -y fail2ban dos2unix git language-pack-zh-hans
apt install -y linux-generic-hwe-16.04

echo "tcp_bbr" | tee -a /etc/modules-load.d/modules.conf
echo "net.core.default_qdisc = fq" | tee -a /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control = bbr" | tee -a /etc/sysctl.conf
echo "fs.file-max = 1024000" | tee -a /etc/sysctl.conf

echo "* soft nofile 512000" | tee -a /etc/security/limits.conf
echo "* hard nofile 1024000" | tee -a /etc/security/limits.conf
echo "root soft nofile 512000" | tee -a /etc/security/limits.conf
echo "root hard nofile 1024000" | tee -a /etc/security/limits.conf
