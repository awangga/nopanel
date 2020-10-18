#!/bin/bash
#nginx install
apt install systemd
apt install nginx
systemctl enable nginx
systemctl start nginx
systemctl status nginx

sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update

#php 7.4
apt install php7.4-fpm php7.4-mbstring php7.4-xml php7.4-mysql php7.4-pgsql php7.4-common php7.4-gd php7.4-json php7.4-cli php7.4-curl php7.4-zip php7.4-intl php7.4-xmlrpc php7.4-soap
systemctl start php7.4-fpm
systemctl status php7.4-fpm
systemctl enable php7.4-fpm

