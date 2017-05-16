# Preparation
## Setting IP
```sh
# vi /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
HWADDR=36:65:32:30:64:62
TYPE=Ethernet
UUID=20877662-0a04-4b9e-b2e4-8432dc956acc
ONBOOT=yes
NM_CONTROLLED=no
#BOOTPROTO=dhcp
NETMASK=255.255.254.0
IPADDR=10.14.207.252
GATEWAY=10.14.207.254
DNS1=10.14.207.254
```
## Create sudoers
```sh
# useradd admin
# passwd admin
# vi /etc/sudoers.d/admin
%admin	ALL=(ALL)	ALL
```
## run vncserver
```sh
$ sudo yum groupinstall Desktop
$ sudo yum install tigervnc-server
$ vncpasswd
$ vncserver
```
## Install Dependencies
```sh
$ sudo yum install compat-libstdc++-33.x86_64 binutils elfutils-libelf elfutils-libelf-devel
$ sudo yum install glibc glibc-common glibc-devel glibc-headers gcc gcc-c++ libaio-devel
$ sudo yum install libaio libgcc libstdc++ libstdc++ make sysstat unixODBC unixODBC-devel
$ sudo yum install unzip
```
## Create user and config profile
```sh
$ sudo groupadd oinstall
$ sudo groupadd dba
$ sudo useradd -m -g oinstall -G dba -s /bin/bash oracle
$ sudo passwd oracle
$ id nobody
uid=99(nobody) gid=99(nobody) groups=99(nobody)
```
## Kernel Setting
```sh
$ vi /etc/sysctl.conf
kernel.sem = 250 32000 100 128
fs.file-max = 6815744
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
fs.aio-max-nr = 1048576
$ sudo sysctl -p
$ sudo vi /etc/security/limits.conf
oracle soft nproc  2047
oracle hard nproc  16384
oracle soft nofile 1024
oracle hard nofile 65536
$ sudo vi /etc/pam.d/login
session required /lib64/security/pam_limits.so
session required pam_limits.so
```
## Profile Settings
```sh
$ sudo vi /etc/profile.d/custom.sh
#!/bin/bash

if [ $USER = "oracle" ]; then
  if [ $SHELL = "/bin/ksh" ]; then
    ulimit -p 16384
    ulimit -n 65536
  else
    ulimit -u 16384 -n 65536
  fi
fi
$ sudo chmod +x /etc/profile.d/custom.sh
$ sudo mkdir -p /opt/app/oracle/product/11.2.0
$ sudo chown -R oracle:oinstall /opt/app
$ sudo chmod -R 775 /opt/app
$ su oracle
$ vi ~/.bash_profile
umask 022

export TMPDIR=$TMP
export ORACLE_BASE=/opt/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export PATH=$ORACLE_HOME/bin:$PATH
$ source ~/.bash_profile
$ exit
```
## Oracle Installation
Please use vnc to login and run ./runInstaller from oracle user


http://eduardo-lago.blogspot.co.id/2012/01/how-to-install-oracle-11g-database.html