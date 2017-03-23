# SOA Oracle 11g

## Oracle 11g
### Desktop GUI
```sh
$ sudo apt-get install xfce4 xfce4-goodies tightvncserver
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


# Reference
 1. http://tutorialforlinux.com/2016/03/29/how-to-install-oracle-11g-r2-database-on-ubuntu-16-04-xenial-lts-64bit-easy-guide-users-directories-set-up/
 2. http://paperiniktips.sviluppo-siti-web.com/oracle-11g-r2-installation-ubuntu-like-solve-error-agent-nmhs-makefile/
 3. http://paperiniktips.sviluppo-siti-web.com/oracle-11c-database-linux-installation-troubleshooting-error-in-invoking-target-all_no_orcl-of-makefile/



