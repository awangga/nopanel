# SISTER

# Langkah:

### 1. Installasi php 5.6 dan nginx

### 2. Instalasi php-extension, dan pastikan semua extension yang ada disini terinstall

> libapache2-mod-php5.6
> php-common
> php5.6
> php5.6-cli
> php5.6-common
> php5.6-curl
> php5.6-json
> php5.6-mbstring
> php5.6-mcrypt
> php5.6-mysql
> php5.6-odbc
> php5.6-opcache
> php5.6-pgsql
> php5.6-readline
> php5.6-xml

### 3. Lihat module php yang aktif dengan menggunakan php5.6 -m

> [PHP Modules]
> calendar
> Core
> ctype
> curl
> date
> dom
> ereg
> exif
> fileinfo
> filter
> ftp
> gettext
> hash
> iconv
> json
> libxml
> mbstring
> mcrypt
> mhash
> mysql
> mysqli
> mysqlnd
> odbc
> openssl
> pcntl
> pcre
> PDO
> pdo_mysql
> PDO_ODBC
> pdo_pgsql
> pgsql
> Phar
> posix
> readline
> Reflection
> sdid
> session
> shmop
> SimpleXML
> sockets
> SPL
> standard
> sysvmsg
> sysvsem
> sysvshm
> tokenizer
> wddx
> xml
> xmlreader
> xmlwriter
> xsl
> Zend OPcache
> zlib
> [Zend Modules]
> Zend OPcache

###4. Ada module custom yang digunakan sister, yaitu sdid.so. pada vm sister copy sdid.so dari folder /usr/lib/php/20131226 ke server yang akan digunakan ke folder php anda, untuk mengetahui foldernya dimana gunakan "php -i | grep extension_dir"

###5. Setelah dicopy, aktifkan extension dengan membuat file .ini baru pada folder php fpm, yaitu pada folder

> /etc/php/5.6/mods-available/sdid.ini

> /etc/php/5.6/fpm/conf.d/30-sdid.ini

> /etc/php/5.6/cli/conf.d/30-sdid.ini

###6. Isi ketiga file tersebut dengan ini

> ; priority=30
> extension = sdid.so

###7. Lalu masukkan config ini pada nginx, edit sesuai kebutuhan

> server {

    listen 80;
    server_name sister.poltekpos.ac.id;
    root /var/www/html/SISTER/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php5.6-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
    }

###8. database, install postgresql versi 9.5, pastikan telah jalan lalu copy seluruh folder yang ada pada /var/lib/postgres/9.5/main ke folder tempat menyimpan db postgres pada server (default dari image docker /var/lib/postgres/data)
