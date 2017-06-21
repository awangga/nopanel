#!/bin/bash


wget https://sourceforge.net/projects/idempiere/files/v3.1/daily-server/idempiereServer3.1Daily.gtk.linux.x86_64.zip/download
mv download idempiereServer3.1Daily.gtk.linux.x86_64.zip
unzip idempiereServer3.1Daily.gtk.linux.x86_64.zip
wget https://sourceforge.net/projects/idempiere/files/v3.1/daily-server/idempiereServer3.1Daily.gtk.linux.x86_64.deb/download
mv download idempiereServer3.1Daily.gtk.linux.x86_64.deb

apt-get update
apt-get install default-jdk
apt-get install postgresql postgresql-contrib
echo "host		all		all		192.168.100.0/24	md5" >> /etc/postgresql/9.5/main/pg_hba.conf
systemctl restart postgresql
echo "set password for user postgres"
passwd postgres
echo "go to psql and run : ALTER USER postgres PASSWORD 'newpasword';\q; GRANT ALL PRIVILEGES ON database idempiere TO adempiere;"
su postgres

sh console-setup.sh
