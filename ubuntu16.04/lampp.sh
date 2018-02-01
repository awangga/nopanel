#!/bin/bash
sudo apt install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx
sudo apt install mariadb-server mariadb-client
sudo systemctl status mysql
sudo systemctl start mysql
sudo systemctl enable mysql
sudo apt install php7.0-fpm php7.0-mbstring php7.0-xml php7.0-mysql php7.0-common php7.0-gd php7.0-json php7.0-cli php7.0-curl
sudo systemctl start php7.0-fpm
sudo systemctl status php7.0-fpm
sudo systemctl enable php7.0-fpm
sudo mysql -u root
sudo mysql_secure_installation
echo "> use mysql;"
echo "update user set plugin='' where User='root';"
echo "flush privileges;"
echo "exit"
