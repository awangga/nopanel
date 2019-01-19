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
#if need mdb2
#apt install php-fpm php-mbstring php-xml php-mysql php-common php-gd php-json php-cli php-curl php-mdb2
#apt install -y software-properties-common
#LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
#apt install php5.6-fpm php5.6-mbstring php5.6-xml php5.6-mysql php5.6-common php5.6-gd php5.6-json php5.6-cli php5.6-curl
#update-alternatives --config php
sudo systemctl start php7.0-fpm
sudo systemctl status php7.0-fpm
sudo systemctl enable php7.0-fpm
sudo mysql -u root
sudo mysql_secure_installation
echo "> use mysql;"
echo "update user set plugin='' where User='root';"
echo "flush privileges;"
echo "exit"

#mdb2
#sudo apt install php-mdb2-driver-mysql
#sudo apt-get install php-pear
#pear install MDB2
#pear install MDB2_Driver_Mysql
#pear install MDB2_Driver_mysqli
#pear upgrade mdb2-beta mdb2_driver_mysqli-beta