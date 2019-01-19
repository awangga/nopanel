#!/bin/bash
sudo apt-get install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx
sudo apt-get install mariadb-server mariadb-client
sudo systemctl status mysql
sudo systemctl start mysql
sudo systemctl enable mysql
apt-get install -y software-properties-common
LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get install -y php5.6-fpm php5.6-mbstring php5.6-xml php5.6-mysql php5.6-common php5.6-gd php5.6-json php5.6-cli php5.6-curl
update-alternatives --config php
sudo systemctl start php5.6-fpm
sudo systemctl status php5.6-fpm
sudo systemctl enable php5.6-fpm
sudo mysql -u root
sudo mysql_secure_installation
echo "> use mysql;"
echo "update user set plugin='' where User='root';"
echo "flush privileges;"
echo "exit"


sudo apt-get install php-mdb2-driver-mysql
sudo apt-get install php-pear
pear install MDB2
#pear install MDB2_Driver_Mysql
pear install MDB2_Driver_mysqli
pear upgrade mdb2-beta mdb2_driver_mysqli-beta
apt-get install git