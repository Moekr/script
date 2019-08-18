#!/bin/bash

mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
wget -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/Moekr/script/master/nginx/nginx.conf
mkdir -p /etc/nginx/error-page
wget -O /etc/nginx/error-page/404.html https://raw.githubusercontent.com/Moekr/script/master/nginx/404.html
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
wget -O /etc/nginx/sites-available/default https://raw.githubusercontent.com/Moekr/script/master/nginx/default

nginx -t && nginx -s reload
