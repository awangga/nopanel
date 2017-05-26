#!/bin/bash

wget http://eu.dl.alfresco.com.s3.amazonaws.com/release/community/201704-build-00019/alfresco-community-installer-201704-linux-x64.bin
sudo apt-get install libfontconfig
sudo apt-get install libsm-dev
sudo apt-get install libice-dev
sudo apt-get install libxrender-dev
sudo apt-get install libxext-dev
sudo apt-get install libcups2
sudo apt-get install libglu1-mesa-dev 
sudo apt-get install libcairo2-dev
sudo apt-get install libgl1-mesa-glx

./alfresco-community-installer-201704-linux-x64.bin

mv ~/alfresco-community/tomcat/shared/classes/alfresco-global.properties ~/alfresco-community/tomcat/shared/classes/alfresco-global.properties.bak
mv alfresco-global.properties ~/alfresco-community/tomcat/shared/classes/


mv ~/alfresco-community/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml ~/alfresco-community/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml.bak
mv share-config-custom.xml ~/alfresco-community/tomcat/shared/classes/alfresco/web-extension/


~/alfresco-community/alfrestco.sh stop
~/alfresco-community/alfrestco.sh start

sudo apt-get install letsencrypt
sudo letsencrypt certonly --webroot -w /var/www/html -d www.tukang.review
cp alfresco /etc/nginx/sites-enabled/
sudo systemctl restart nginx