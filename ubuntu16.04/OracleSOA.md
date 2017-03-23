# SOA Oracle 11g

## Oracle 11g
### Desktop GUI
```sh
$ sudo apt install xfce4 xfce4-goodies tightvncserver
```
### Pre Requisit
Please Download oracle 11gR2 from oracle website
http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html?ssSourceSiteId=ocomen

```sh
$ sudo echo 'deb http://buaya.klas.or.id/ubuntu/ trusty main restricted universe multiverse' >> /etc/apt/sources.list.d/extra.list
$ sudo echo 'deb http://kambing.ui.ac.id/ubuntu/ precise main restricted universe multiverse' >> /etc/apt/sources.list.d/extra.list
$ sudo rm -rf /var/lib/apt/lists/*
$ sudo apt-get update
$ sudo apt-get install alien autoconf automake autotools-dev binutils doxygen \
elfutils expat gawk gcc gcc-multilib g++-multilib libstdc++6:i386 ksh less libtiff5 \
libtiff5-dev lib32z1 libaio1 libaio-dev libc6-dev libc6-dev-i386 libc6-i386 \
libelf-dev libltdl-dev libmotif4 libodbcinstq4-1 libodbcinstq4-1:i386 \
libpthread-stubs0 libpthread-stubs0-dev libpth-dev libstdc++5 lsb-cxx make \
pdksh openssh-server rlwrap rpm sysstat unixodbc unixodbc-dev x11-utils \
zlibc libglapi-mesa:i386 libglu1-mesa:i386 libqt4-opengl:i386 \
libpthread-workqueue0 libpthread-workqueue-dev libzthread-2.3-2 libzthread-dev
$ sudo mv /etc/apt/sources.list.d/extra.list /etc/apt/sources.list.d/extra.list.backup
$ sudo apt-get update
$ sudo ln -s /usr/bin/awk /bin/awk
$ sudo ln -s /usr/bin/rpm /bin/rpm
$ sudo ln -s /usr/bin/basename /bin/basename
$ sudo ln -s /usr/lib/x86_64-linux-gnu /usr/lib64
$ cd /lib64
$ sudo ln -s /lib/x86_64-linux-gnu/libgcc_s.so.1 .
```
Make user and group
```sh
$ sudo groupadd -g 502 oinstall
$ sudo groupadd -g 503 dba
$ sudo groupadd -g 504 oper
$ sudo groupadd -g 505 asmadmin
$ sudo useradd -u 502 -g oinstall -G dba,asmadmin,oper -s /bin/bash -m oracle
$ sudo passwd oracle
```
make target directories
```sh
$ sudo mkdir -p /u01/app/oracle/product/11.2.0/
$ sudo chown -R oracle:oinstall /u01
$ sudo chmod -R 775 /u01
```
move installer
```sh
$ cd /home/[myUser]/Downloads
$ unzip linux_11gR2_database_1of2.zip
$ unzip linux_11gR2_database_2of2.zip
$ sudo chown -R oracle:oinstall database
$ sudo mv database /tmp
$ su oracle
$ nano ~/.bashrc

# Oracle Settings
TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR
ORACLE_HOSTNAME=[HOSTNAME]; export ORACLE_HOSTNAME
ORACLE_UNQNAME=DB11G; export ORACLE_UNQNAME
ORACLE_BASE=/u01/app/oracle; export ORACLE_BASE
ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1; export ORACLE_HOME
ORACLE_SID=[DBSID]; export ORACLE_SID
PATH=/usr/sbin:$PATH; export PATH
PATH=$ORACLE_HOME/bin:$PATH; export PATH
LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib:/usr/lib64; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH

$ vncserver
$ cd /tmp/database
$ chmod -R +x /tmp/database
$ ./runInstaller
$ vncserver -kill :1
```
PLease change [HOSTNAME] and [DBSID]



## JDK 7

```sh
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo add-apt-repository ppa:webupd8team/java
$ sudo apt-get update
$ sudo apt-get install oracle-java7-installer
$ sudo update-alternatives --config java
$ sudo nano /etc/environment
JAVA_HOME="/usr/lib/jvm/java-8-oracle"
$ source /etc/environment
$ echo $JAVA_HOME
```


### Mariadb
yum install mariadb mariadb-server net-tools
systemctl enable mariadb.service
systemctl start mariadb.service
mysql_secure_installation

### Nginx

```sh
# vi /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
# yum install nginx
# systemctl enable nginx.service
# systemctl start nginx.service
```

### Open Port on Firewall

```sh
# firewall-cmd --permanent --zone=public --add-service=http
# firewall-cmd --permanent --zone=public --add-service=https
# firewall-cmd --reload
```

### PHP 5

```sh
# yum install php-fpm php-cli php-mysql php-gd php-ldap php-odbc php-pdo php-pecl-memcache php-pear php-mbstring php-xml php-xmlrpc php-mbstring php-snmp php-soap
# yum install php php-mysql php-fpm
```

### APC

```sh
# yum install php-devel
# yum groupinstall 'Development Tools'
# pecl install apc
# pecl install apc
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


```sh
# vi /etc/php.ini
cgi.fix_pathinfo=0:
extension=apc.so
[Date]
date.timezone = "Asia/Jakarta"
# cat /etc/sysconfig/clock
```

### Enable php-fpm

```sh
# vi /etc/php-fpm.d/www.conf
listen = /var/run/php-fpm/php-fpm.sock
listen.owner = nobody
listen.group = nobody
user = app
group = app

# systemctl enable php-fpm.service
# systemctl start php-fpm.service
```

### Increase Worker
vi /etc/nginx/nginx.conf
```sh
[...]
worker_processes  4;
[...]
    keepalive_timeout  2;
[...]
```

### Nginx Config PHP

```sh
# vi /etc/nginx/conf.d/default.conf
server {
    listen       80;
    server_name  localhost;

	root   /usr/share/nginx/html;
	index  index.php index.html index.htm;

   location ~ \.php$ {
        fastcgi_pass   unix:/var/run/php-fpm/php-fpm.sock;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
}

# systemctl restart nginx.service
```

### install php-mcrypt

```sh
# yum -y install epel-release
# yum -y install php-mcrypt
# chcon system_u:object_r:textrel_shlib_t:s0 /usr/lib64/php/modules/mcrypt.so
# systemctl restart php-fpm
```

## Selinux enable httpd

```sh
# getsebool -a
# setsebool -P httpd_can_network_connect on
# setsebool -P httpd_read_user_content 1
```

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
###Config Varnish

```sh
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
rpm -ivh epel-release-7-5.noarch.rpm
yum install varnish
vi /etc/varnish/varnish.params
vi /etc/varnish/default.vcl

systemctl enable varnish
systemctl enable httpd
systemctl start varnish
systemctl start httpd
```

### SSL

```sh
# mkdir /etc/nginx/ssl
# cd /etc/nginx/ssl
# openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr
# cat server.csr
```
## Tracing error

```sh
# tail -f /var/log/messages
```


# Reference
 1. https://www.howtoforge.com/how-to-install-nginx-with-php-and-mysql-lemp-stack-on-centos-7
 2. http://www.unixmen.com/install-varnish-cache-4-0-centos-7/
 3. http://www.liquidweb.com/kb/how-to-stop-and-disable-firewalld-on-centos-7/
 4. http://www.tecmint.com/install-varnish-cache-web-accelerator/2/
 5. https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-centos-7


