sudo apt install php7.1-zip php7.1-intl php7.1-xmlrpc php7.1-soap
mariadb -u root -p

#MariaDB [(none)]> CREATE DATABASE mila DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
#MariaDB [(none)]> GRANT ALL ON mila.* TO 'mila'@'localhost' IDENTIFIED BY 'rollyganteng';
#MariaDB [(none)]> FLUSH PRIVILEGES;
#MariaDB [(none)]> EXIT;

cd /tmp
wget https://download.moodle.org/stable38/moodle-latest-38.tgz
tar -xvzf moodle-latest-38.tgz -C /var/www/html/
cd /var/www/html
mv moodle mila
chown -R www-data:www-data mila/
chmod -R 755 mila/
mkdir miladata
chown -R www-data:www-data miladata/
chmod -R 0770 miladata/
sudo nano /etc/nginx/sites-enabled/mila

#########################################
server {
    server_name mila.stimlog.ac.id;
    root /var/www/html/mila;
    index  index.php index.html index.htm;

    location / {
    try_files $uri $uri/ =404;
    }

    location /dataroot/ {
    internal;
    alias /var/www/html/miladata/;
    }

    location ~ [^/]\.php(/|$) {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.1-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

}
############################################

sudo nano /var/www/html/mila/config.php
#############################################
<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mariadb';
$CFG->dblibrary = 'native';
$CFG->dbhost    = 'localhost';
$CFG->dbname    = 'mila';
$CFG->dbuser    = 'mila';
$CFG->dbpass    = 'rollyganteng';
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => '',
  'dbsocket' => '',
  'dbcollation' => 'utf8mb4_general_ci',
);

$CFG->wwwroot   = 'http://mila.stimlog.ac.id';
$CFG->dataroot  = '/var/www/html/miladata';
$CFG->admin     = 'admin';

$CFG->directorypermissions = 0755;

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
###############################################