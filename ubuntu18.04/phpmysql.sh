#!/bin/bash
#nginx install
sudo apt install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx

#add php repository and install php
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update	

#php 5.6
sudo apt install php5.6-fpm php5.6-mbstring php5.6-xml php5.6-mysql php5.6-common php5.6-gd php5.6-json php5.6-cli php5.6-curl
sudo systemctl start php5.6-fpm
sudo systemctl status php5.6-fpm
sudo systemctl enable php5.6-fpm

#php 7.1
sudo apt install php7.1-fpm php7.1-mbstring php7.1-xml php7.1-mysql php7.1-common php7.1-gd php7.1-json php7.1-cli php7.1-curl
sudo systemctl start php7.1-fpm
sudo systemctl status php7.1-fpm
sudo systemctl enable php7.1-fpm

#pphp 7.4
sudo apt install php7.4-fpm php7.4-mbstring php7.4-xml php7.4-mysql php7.4-common php7.4-gd php7.4-json php7.4-cli php7.4-curl
sudo systemctl start php7.4-fpm
sudo systemctl status php7.4-fpm
sudo systemctl enable php7.4-fpm

#mariadb install
sudo apt install mariadb-server mariadb-client
sudo systemctl status mariadb
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation
sudo mysql -u root
echo "> use mysql;"
echo "update user set plugin='' where User='root';"
echo "flush privileges;"
echo "exit"

#add user osdep to www-data
sudo usermod -a -G www-data osdep

#generate deploy key
ssh-keygen -t rsa -b 4096 -C "rolly@awang.ga"
cat .ssh/id_rsa.pub
#Change owner from root to nginx user
sudo chown -R www-data:www-data /var/www/html/