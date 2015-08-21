# nopanel
Web Hosting Panel for Advance User
###Preparation for installation
1. Install Webmin
   - add repository
   - add signature
   - yum install webmin
2. Install Virtualmin
   - wget http://*wbm*.rpm
   - wget http://*wbt*.rpm
   - rpm -ivh wbm*.rpm
   - rpm -ivh *wbt*.rpm
3. Virtualmin theme activated from webmin user interface
   - login to your webmin interface on webmin menu choose Change Language and Theme>Personal choice ..  
   - klik make changes
   - close browser and open your webmin user interface again
4. Install MySQL
   - yum install mysql-server
   - service mysqld start
   - /usr/bin/mysqladmin -u root password 'new-password'
   - /usr/bin/mysqladmin -u root -h semar.passionit.net password 'new-password'
   - /usr/bin/mysql_secure_installation
   - service mysqld start
   - chkconfig mysqld on
   - input your root password on webmin
5. Install Postgresql
   - yum install postgresql-server postgresql postgresql-contrib php-pgsql
   - chkconfig postgresql on
   - service postgresql initdb
   - service postgresql start
   - su postgres
   - psql template1
   - ALTER USER postgres with password 'passwordku';\q
   - nano /var/lib/pgsql/data/pg_hba.conf change ident to password or md5
   - nano /var/lib/pgsql/data/postgresql.conf
   - listen_addreses="localhost"
6. Taken from [The Web Site People]. Create file /home/chroot/chroot.sh with in the repo give executable permission
7. Set the home directory template in Virtualmin accordingly:
   - Virtualmin -> System Settings -> Virtualmin Configuration -> Defaults for new domains -> Home directory base: /home/chroot/$USER/home
   - Virtualmin -> System Settings -> Virtualmin Configuration -> Defaults for new domains -> Home subdirectory: $DOM
   - Note that both settings are required, even if ${DOM} is the default, as Virtualmin will not correctly interpolate the directory unless a manual template is set.
8. Add a custom command to handle setting up and cleaning up the chroot:
   - Virtualmin -> System Settings -> Virtualmin Configuration ->Actions upon server and user creation -> Command to run before making changes to a server: /home/chroot/chroot.sh
   - Virtualmin -> System Settings -> Virtualmin Configuration ->Actions upon server and user creation -> Command to run after making changes to a server: /home/chroot/chroot.sh
9. Create Group : sftponly
10. Add Virtualmin users to a secondary group that sshd can identify for SFTP-only access:
   - Virtualmin -> System Settings -> Server Templates -> Default Settings -> Administration user -> Add domain owners to secondary group: sftponly
11. Update /etc/ssh/sshd_config to set SFTP-only access for members of this group:
   - Subsystem       sftp    internal-sftp
   - Match Group sftponly
   	 - ChrootDirectory /home/chroot/%u
     - ForceCommand internal-sftp
     - AllowTcpForwarding no   

12. Reload sshd:
``
$ services sshd reload
``

###PHP
```sh
# yum install php php-mysql php-pgsql
# service httpd reload
```


###ssl for https
```sh
# yum install mod_ssl openssl
# openssl genrsa -des3 -out your-domain.com.key 4096
# openssl req -new -key your-domain.com.key -out your-domain.com.csr
# openssl x509 -req -days 700 -in your-domain.com.csr -signkey your-domain.com.key -out your-domain.com.crt
# mkdir -p /etc/httpd/ssl/
# cp your-domain.com.crt /etc/httpd/ssl/
# cp your-domain.com.key /etc/httpd/ssl/
# vi /etc/httpd/conf.d/your-domain.com.conf
# service httpd restart
```

###add EPEL Repositories
```sh
# wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# rpm -ivh epel-release-6-8.noarch.rpm
```

###phpmyadmin
```sh
# yum install phpmyadmin
# vim /etc/httpd/conf.d/phpMyAdmin.conf
# service httpd reload
```

###mod-itk for running vhost as vhost user
```sh
# yum install httpd-itk
# nano /etc/sysconfig/httpd
add this:
HTTPD=/usr/sbin/httpd.itk
# nano /etc/httpd/conf.d/mpm-itk.conf
add this:
<IfModule itk.c>  
  StartServers 5  
  MinSpareServers 10  
  MaxSpareServers 20  
  ServerLimit 812
  MaxClients 812 
  MaxRequestsPerChild 20
</IfModule>
# nano /etc/httpd/conf.d/php.conf
add this :
<IfModule itk.c>
   LoadModule php5_module modules/libphp5.so
</IfModule>
# nano /etc/httpd/conf/httpd.conf
add this in virtual host:
AssignUserId user group
# service httpd restart
```
login to virtualmin, goto  System Settings>Server Templates>Default Settings>Apache website
Directives and settings for new websites:
```
ServerName ${DOM}
ServerAlias www.${DOM}
DocumentRoot ${HOME}/public_html
AssignUserId ${USER} ${USER}
ErrorLog /var/log/virtualmin/${DOM}_error_log
CustomLog /var/log/virtualmin/${DOM}_access_log combined
ScriptAlias /cgi-bin/ ${HOME}/cgi-bin/
DirectoryIndex index.html index.htm index.php index.php4 index.php5
<Directory ${HOME}/public_html>
Options -Indexes +IncludesNOEXEC +SymLinksIfOwnerMatch
allow from all
AllowOverride All Options=ExecCGI,Includes,IncludesNOEXEC,Indexes,MultiViews,SymLinksIfOwnerMatch
</Directory>
<Directory ${HOME}/cgi-bin>
allow from all
AllowOverride All Options=ExecCGI,Includes,IncludesNOEXEC,Indexes,MultiViews,SymLinksIfOwnerMatch
</Directory>
```


###Usermin
```sh
# rpm -Uvh http://www.webmin.com/download/rpm/usermin-current.rpm
# service usermin restart
```
Login from web browser https://yourdomain:20000

###Update Mysql
```sh
# rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
# yum --enablerepo=remi,remi-test install mysql mysql-server
# service mysqld restart
# chkconfig --levels 235 mysqld on
# mysql_upgrade -u root -p
```
###MySQL migration 
On Source Server
```sh
mysqldump -u root -p --opt [database name] > [database name].sql
scp [database name].sql [username]@[servername]:path/to/database/
scp newdatabase.sql user@example.com:~/
```

Or dump all databases into separate file
```sh
#! /bin/bash
 
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/$TIMESTAMP"
MYSQL_USER="backup"
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD="password"
MYSQLDUMP=/usr/bin/mysqldump
 
mkdir -p "$BACKUP_DIR/mysql"
 
databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`
 
for db in $databases; do
  $MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/mysql/$db.gz"
done
```

On Destination Server
```sh
mysql -u root -p newdatabase < /path/to/newdatabase.sql
```
###Mysql CPU Limit
Limiting MySQL proses prevent CPU High Load, install by command: yum install cpulimit
```sh
# cpulimit -l 150 -p 1409 & 
```
Where 150 is % of CPU usage(percentage is multiply by core in your server) and 1409 id PID get from top command use kill command to stop

###set time in OpenVZ VPS to Asia/Jakarta
```sh
# mv /etc/localtime /etc/localtime.bak
# ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
```

### Install Varnish
```sh
# nano /etc/httpd/conf/httpd.conf
edit to : Listen 8080 and ServerName domain:8080 and <VirtualHost *:8080>
# yum install varnish
# nano /etc/sysconfig/varnish
edit:
VARNISH_VCL_CONF=/etc/varnish/default.vcl
VARNISH_LISTEN_ADDRESS=
VARNISH_LISTEN_PORT=80
VARNISH_MIN_THREADS=1
VARNISH_MAX_THREADS=1000
VARNISH_THREAD_TIMEOUT=120
VARNISH_STORAGE_SIZE=512M
#u can leave varnish storage
#VARNISH_STORAGE=”malloc,${VARNISH_STORAGE_SIZE}”
VARNISH_SECRET_FILE=/etc/varnish/secret
VARNISH_TTL=120
Uncomment the DAEMON_OPTS line following the above lines.
# nano /etc/varnish/default.vcl 
backend default {
  .host = "127.0.0.1";
  .port = "8080";
}
# service varnish restart
# chkconfig varnish on
```
for multiple domain
```sh
backend example1 {
     .host = "backend.example1.com";
     .port = "8080";
 }
 backend example2 {
      .host = "backend.example2.com";
      .port = "8080";
 }
 sub vcl_recv {
    if (req.http.host == "example1.com") {
        #You will need the following line only if your backend has multiple virtual host names
        set req.http.host = "backend.example1.com";
        set req.backend = example1;
        return (lookup);
    }
    if (req.http.host == "example2.com") {
        #You will need the following line only if your backend has multiple virtual host names
        set req.http.host = "backend.example2.com";
        set req.backend = example2;
        return (lookup);
    }
 }
```


### SSL Termination with Varnish and Nginx
```sh
# yum install nginx
# vi /etc/nginx/conf.d/default.conf 
listen       8000 default_server;
# mkdir /etc/nginx/ssl
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
# vi /etc/nginx/sites-enabled/default
server {
        listen 443 ssl;

        server_name example.com;
        ssl_certificate /etc/nginx/ssl/nginx.crt;
        ssl_certificate_key /etc/nginx/ssl/nginx.key;

        location / {
            proxy_pass http://127.0.0.1:80;
            proxy_set_header X-Real-IP  $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto https;
            proxy_set_header X-Forwarded-Port 443;
            proxy_set_header Host $host;
        }
}
# service nginx start
# chkconfig nginx on
```
Access to your https server : https://varnish_VPS_public_IP and then ok.

### Install Gitlab
```sh
# vi /etc/gitlab/gitlab.rb
# Disable the built-in Postgres
postgresql['enable'] = false

gitlab_rails['db_adapter'] = 'postgresql'
gitlab_rails['db_encoding'] = 'utf8'
# Create database manually and place its name here.
gitlab_rails['db_database'] = 'gitlabhq_production'
gitlab_rails['db_host'] = 'localhost'
gitlab_rails['db_port'] = '5432'
gitlab_rails['db_username'] = 'git' # Database owner.
gitlab_rails['db_password'] = 'git' # Database owner's password.
# gitlab-ctl reconfigure
# gitlab-rake gitlab:setup

```

### IPTables Knowing open port
```sh
# iptables -nL | grep 8999
# iptables -L -n
# netstat -tulpn
```
####Open port XY
Open flle /etc/sysconfig/iptables:
```sh

# vi /etc/sysconfig/iptables
```

Append rule as follows:

-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport XY -j ACCEPT

Save and close the file. Restart iptables:
```sh
# /etc/init.d/iptables restart
```




### Upgrade PHP
```sh
# yum list installed | grep php
# yum remove php.x86_64 php-cli.x86_64 php-common.x86_64 php-gd.x86_64 php-ldap.x86_64 php-mbstring.x86_64 php-mcrypt.x86_64 php-mysql.x86_64 php-pdo.x86_64
# rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
# yum list available | grep php
# yum list available | grep php54
# yum install php54w.x86_64 php54w-cli.x86_64 php54w-common.x86_64 php54w-gd.x86_64 php54w-ldap.x86_64 php54w-mbstring.x86_64 php54w-mcrypt.x86_64 php54w-mysql.x86_64 php54w-pdo.x86_64
# php -v 
# service httpd restart
```

### OCI8 PHP Extension
```sh
# sudo yum install php54w-pear.noarch php54w-devel.x86_64 zlib zlib-devel bc libaio glibc
# sudo yum groupinstall "Development Tools"
# wget http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
# rpm -ivh oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
# rpm -ivh oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm 
# vim /etc/profile.d/oracle.sh
export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
# source /etc/profile.d/oracle.sh
# pecl install -f oci8-1.4.10
instantclient,/usr/lib/oracle/12.1/client64/lib
# vim /etc/php-zts.d/oci8.ini
extension=oci8.so
# vim /etc/httpd/conf.d/php.conf

<IfModule prefork.c>
  LoadModule php5_module modules/libphp5.so
</IfModule>
<IfModule worker.c>
  LoadModule php5_module modules/libphp5-zts.so
</IfModule>
<IfModule itk.c>
   LoadModule php5_module modules/libphp5.so
</IfModule>


AddHandler php5-script .php
AddType text/html .php

DirectoryIndex index.php

# service httpd restart

```

### Set PHP Time Zone
TO avoid timezone warning in PHP 
```sh
PHP Warning:  Unknown: It is not safe to rely on the system's timezone settings. You are *required* to use the date.timezone setting or the date_default_timezone_set() function.
# php -i | grep "Loaded Configuration File"
```
please set in /etc/php.ini
```sh
[Date]
; Defines the default timezone used by the date functions
; http://php.net/date.timezone
date.timezone = "Asia/Jakarta"
```


License
----

GNU Affero General Public License

[The Web Site People]:http://blog.thewebsitepeople.org/2012/10/virtualmin-sftp-chroot/

[The Geek Stuff]:http://www.thegeekstuff.com/2012/03/chroot-sftp-setup/

[Virtualmin Manual]:http://www.virtualmin.com/documentation/developer/prepost

[Rosehosting]https://www.rosehosting.com/blog/installing-and-securing-phpmyadmin-4-on-centos-6/

[mpm-itk]http://itsol.biz/apache-virtual-hosts-with-different-users-centos-6-2-and-apache-2-2/

[Update MySQL]http://stackoverflow.com/questions/9361720/update-mysql-version-from-5-1-to-5-5-in-centos-6-2

[My SQL Migration]https://www.digitalocean.com/community/tutorials/how-to-migrate-a-mysql-database-between-two-servers

[Openvz Change Time]http://forum.openvz.org/index.php?t=msg&goto=37402&

[CPULimit]http://www.server-world.info/en/note?os=CentOS_6&p=cpulimit

[Varnish HTTPS]https://www.digitalocean.com/community/tutorials/how-to-configure-varnish-cache-4-0-with-ssl-termination-on-ubuntu-14-04

[SQL Dump]http://dev.mensfeld.pl/2013/04/backup-mysql-dump-all-your-mysql-databases-in-separate-files/

[OCI8 Install]http://shiki.me/blog/installing-pdo_oci-and-oci8-php-extensions-on-centos-6-4-64bit/

[Install Oracle]http://www.davidghedini.com/pg/entry/install_oracle_11g_xe_on

[Upgrade PHP]http://pkgs.org/centos-6/remi-testing-x86_64/php56-php-oci8-5.6.12-0.1.RC1.el6.remi.x86_64.rpm.html

[Upgrade with remi]http://serverfault.com/questions/638893/upgrading-to-php-5-6-using-yum-remi-repo

[Jboss Instalation]http://opensourcearchitect.co/tutorials/installing-jboss-7-1-on-centos-6
