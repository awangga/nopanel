#!/bin/bash
sudo apt-get install postgresql
sudo apt-get install jdk8

wget https://sourceforge.net/projects/idempiere/files/v3.1/daily-server/idempiereServer3.1Daily.gtk.linux.x86_64.zip/download
mv download idempiereServer3.1Daily.gtk.linux.x86_64.zip
unzip idempiereServer3.1Daily.gtk.linux.x86_64.zip
wget https://sourceforge.net/projects/idempiere/files/v3.1/daily-server/idempiereServer3.1Daily.gtk.linux.x86_64.deb/download
mv download idempiereServer3.1Daily.gtk.linux.x86_64.deb

sudo apt-get update
sudo apt-get install default-jdk
sudo apt-get install postgresql postgresql-contrib

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-16-04