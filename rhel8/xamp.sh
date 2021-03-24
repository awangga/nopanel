#!/bin/sh

#clean dan update repositori
yum clean all
yum repolist
yum update

#disable selinux firewall
setenforce 0
getenforce
sestatus
vi /etc/selinux/config
#SELINUX=permissive
systemctl disable firewalld
systemctl stop firewalld

#Install httpd dan php dan library php-mysql
yum group list -v hidden |grep -i web
yum group install web-server
# tambahkan repo komunitas dan install php
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf install php php-cli php-common php-mysqlnd

#Install mariadb sebagai laternatif mysql, start, enable mariadb
dnf install mariadb-server
systemctl start mariadb
systemctl enable mariadb
systemctl status mariadb
mysql_secure_installation

#enable start dan test apache web server
systemctl status httpd
systemctl enable httpd
systemctl start httpd
systemctl status httpd

#testing httpd
curl http://localhost|grep -i test

#testing php
cd /var/www/html
vi info.php
#<?php phpinfo(); ?>
curl http://localhost/info.php|grep -i version


#create database untuk wordpress
mysql -u root -p
#create database wordpress;
#create user wordpress@localhost identified by 'redhat';
#grant all privileges on wordpress.* to wordpress@localhost identified by 'redhat';
#flush privileges;
#exit


#download wordpress dan simpan di www/html
cd 
wget https://id.wordpress.org/wordpress-4.9.4-id_ID.tar.gz
ls
tar xvfz wordpress-4.9.4-id_ID.tar.gz
ls -ls
cp -a wordpress /var/www/html
cd /var/www/html/wordpress
mkdir wp-content/uploads
cp wp-config-sample.php wp-config.php
vi wp-config.php
# setting database dbname wordpress, user wordpress pass redhat host localhost
cd ..
chown -R apache:apache wordpress


#check browser localhost

