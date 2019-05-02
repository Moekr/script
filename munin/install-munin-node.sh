#!/usr/bin/env bash

# install dependency and perl module
apt install -y git make libmodule-build-perl liblog-dispatch-perl libnet-server-perl liblwp-useragent-determined-perl
# for CentOS
# yum install -y git make perl-Module-Build perl-Log-Dispatch perl-Net-Server perl-LWP-UserAgent-Determined perl-Net-CIDR

# build and install
git clone https://github.com/munin-monitoring/munin && cd munin && make install && cd .. && rm -rf munin

# make essential directory
mkdir -p /var/log/munin /var/run/munin /usr/local/etc/munin/plugins /usr/local/etc/munin/plugin-conf.d

# copy default config
cp /usr/local/etc/munin/munin-node.conf.sample /usr/local/etc/munin/munin-node.conf

# install plugins
wget -O /usr/local/share/munin/plugins/cpu https://github.com/Moekr/script/raw/master/munin/plugins/cpu && chmod a+x /usr/local/share/munin/plugins/cpu
wget -O /usr/local/share/munin/plugins/df https://github.com/Moekr/script/raw/master/munin/plugins/df && chmod a+x /usr/local/share/munin/plugins/df
wget -O /usr/local/share/munin/plugins/load https://github.com/Moekr/script/raw/master/munin/plugins/load && chmod a+x /usr/local/share/munin/plugins/load
wget -O /usr/local/share/munin/plugins/memory https://github.com/Moekr/script/raw/master/munin/plugins/memory && chmod a+x /usr/local/share/munin/plugins/memory
wget -O /usr/local/share/munin/plugins/tcp https://github.com/Moekr/script/raw/master/munin/plugins/tcp && chmod a+x /usr/local/share/munin/plugins/tcp
ln -s /usr/local/share/munin/plugins/cpu /usr/local/etc/munin/plugins/cpu
ln -s /usr/local/share/munin/plugins/df /usr/local/etc/munin/plugins/df
# ln -s /usr/local/share/munin/plugins/if_ /usr/local/etc/munin/plugins/if_eth0
ln -s /usr/local/share/munin/plugins/iostat /usr/local/etc/munin/plugins/iostat
ln -s /usr/local/share/munin/plugins/load /usr/local/etc/munin/plugins/load
ln -s /usr/local/share/munin/plugins/memory /usr/local/etc/munin/plugins/memory
# ln -s /usr/local/share/munin/plugins/nginx_request /usr/local/etc/munin/plugins/nginx_request
ln -s /usr/local/share/munin/plugins/processes /usr/local/etc/munin/plugins/processes
ln -s /usr/local/share/munin/plugins/tcp /usr/local/etc/munin/plugins/tcp
ln -s /usr/local/share/munin/plugins/threads /usr/local/etc/munin/plugins/threads

# install systemd service
wget -O /lib/systemd/system/munin-node.service https://github.com/Moekr/script/raw/master/munin/systemd/munin-node.service
systemctl enable munin-node.service && systemctl start munin-node.service
