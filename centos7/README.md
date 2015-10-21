# Nopanel Cluster

## Lemp

Linux Nginx MariaDB PHP

### Mariadb
yum install mariadb mariadb-server net-tools
systemctl enable mariadb.service
systemctl start mariadb.service
mysql_secure_installation

### Nginx

vi /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
yum install nginx
systemctl enable nginx.service
systemctl start nginx.service

### Open Port on Firewall

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

### PHP 5

yum install php-fpm php-cli php-mysql php-gd php-ldap php-odbc php-pdo php-pecl-memcache php-pear php-mbstring php-xml php-xmlrpc php-mbstring php-snmp php-soap

### APC

yum install php-devel
yum groupinstall 'Development Tools'
pecl install apc
```sh
[root@example ~]# pecl install apc
downloading APC-3.1.13.tgz ...
Starting to download APC-3.1.13.tgz (171,591 bytes)
.................done: 171,591 bytes
55 source files, building
running: phpize
Configuring for:
PHP Api Version: 20100412
Zend Module Api No: 20100525
Zend Extension Api No: 220100525
Enable internal debugging in APC [no] : <-- ENTER
Enable per request file info about files used from the APC cache [no] : <-- ENTER
Enable spin locks (EXPERIMENTAL) [no] : <-- ENTER
Enable memory protection (EXPERIMENTAL) [no] : <-- ENTER
Enable pthread mutexes (default) [no] : <-- ENTER
Enable pthread read/write locks (EXPERIMENTAL) [yes] : <-- ENTER
building in /var/tmp/pear-build-rootVrjsuq/APC-3.1.13
......
```
vi /etc/php.ini
```sh
cgi.fix_pathinfo=0:
extension=apc.so
[Date]
date.timezone = "Asia/Jakarta"
```
cat /etc/sysconfig/clock

### Enable php-fpm
systemctl enable php-fpm.service
systemctl start php-fpm.service

### Increase Worker
vi /etc/nginx/nginx.conf
```sh
[...]
worker_processes  4;
[...]
    keepalive_timeout  2;
[...]
```

### Virtual Host
vi /etc/nginx/conf.d/default.conf
```sh
[...]
server {
    listen       80;
    server_name  localhost;

    #charset koi8-r;
    #access_log  /var/log/nginx/log/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #

    location ~ \.php$ {
        root           /usr/share/nginx/html;
        try_files $uri =404;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
	
	# deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    location ~ /\.ht {
        deny  all;
    }
}
```
systemctl restart nginx.service

### PHP-FPM Use A Unix Socket
vi /etc/php-fpm.d/www.conf
```sh
[...]
;listen = 127.0.0.1:9000
listen = /var/run/php-fpm/php5-fpm.sock
[...]
```
systemctl restart php-fpm.service
vi /etc/nginx/conf.d/default.conf
```sh
[...]
    location ~ \.php$ {
        root           /usr/share/nginx/html;
        try_files $uri =404;
        fastcgi_pass   unix:/var/run/php-fpm/php5-fpm.sock;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
[...]
```
systemctl restart nginx.service

## Varnish
vi /etc/yum.repos.d/varnish.repo
```sh
[varnish-4.0]
name=Varnish 4.0 for Enterprise Linux
baseurl=https://repo.varnish-cache.org/redhat/varnish-4.0/el7/$basearch
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH
```
Config Varnish
```sh
yum install varnish
vi /etc/varnish/varnish.params
vi /etc/varnish/default.vcl

systemctl enable varnish
systemctl enable httpd
systemctl start varnish
systemctl start httpd
```

# Reference
 1. https://www.howtoforge.com/how-to-install-nginx-with-php-and-mysql-lemp-stack-on-centos-7
 2. http://www.unixmen.com/install-varnish-cache-4-0-centos-7/
 3. http://www.liquidweb.com/kb/how-to-stop-and-disable-firewalld-on-centos-7/
 4. http://www.tecmint.com/install-varnish-cache-web-accelerator/2/


