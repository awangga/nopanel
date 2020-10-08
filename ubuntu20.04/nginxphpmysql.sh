#!/bin/bash
#nginx install
apt install systemd
apt install nginx
systemctl enable nginx
systemctl start nginx
systemctl status nginx

#php 7.3
apt install php7.3-fpm php7.3-mbstring php7.3-xml php7.3-mysql php7.3-pgsql php7.3-common php7.3-gd php7.3-json php7.3-cli php7.3-curl php7.3-zip php7.3-intl php7.3-xmlrpc php7.3-soap
systemctl start php7.3-fpm
systemctl status php7.3-fpm
systemctl enable php7.3-fpm

