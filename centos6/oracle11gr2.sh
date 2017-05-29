#/bin/sh
## Create sudoers

useradd admin
echo "user admin password set"
passwd admin
echo '%admin   ALL=(ALL)   ALL' > /etc/sudoers.d/admin

## run vncserver
yum -y groupinstall Desktop
yum -y install tigervnc-server
## Install Dependencies
yum -y install compat-libstdc++-33.x86_64 binutils elfutils-libelf elfutils-libelf-devel
yum -y install glibc glibc-common glibc-devel glibc-headers gcc gcc-c++ libaio-devel
yum -y install libaio libgcc libstdc++ libstdc++ make sysstat unixODBC unixODBC-devel
yum -y install unzip

## Create user and config profile
groupadd oinstall
groupadd dba
useradd -m -g oinstall -G dba -s /bin/bash oracle
echo "user oracle set password"
passwd oracle
id nobody
## Kernel Setting

echo "kernel.sem = 250 32000 100 128" >> /etc/sysctl.conf
echo "fs.file-max = 6815744" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 9000 65500" >> /etc/sysctl.conf
echo "net.core.rmem_default = 262144" >> /etc/sysctl.conf
echo "net.core.rmem_max = 4194304" >> /etc/sysctl.conf
echo "net.core.wmem_default = 262144" >> /etc/sysctl.conf
echo "net.core.wmem_max = 1048576" >> /etc/sysctl.conf
echo "fs.aio-max-nr = 1048576" >> /etc/sysctl.conf
sysctl -p
echo "oracle soft nproc  2047" >> /etc/security/limits.conf
echo "oracle hard nproc  16384" >> /etc/security/limits.conf
echo "oracle soft nofile 1024" >> /etc/security/limits.conf
echo "oracle hard nofile 65536" >> /etc/security/limits.conf

echo "session required /lib64/security/pam_limits.so" >> /etc/pam.d/login
echo "session required pam_limits.so" >> /etc/pam.d/login


echo "#!/bin/bash" >> /etc/profile.d/custom.sh
echo "if [ \$USER = \"oracle\" ]; then" >> /etc/profile.d/custom.sh
echo "  if [ \$SHELL = \"/bin/ksh\" ]; then" >> /etc/profile.d/custom.sh
echo "    ulimit -p 16384" >> /etc/profile.d/custom.sh
echo "    ulimit -n 65536" >> /etc/profile.d/custom.sh
echo "  else" >> /etc/profile.d/custom.sh
echo "    ulimit -u 16384 -n 65536" >> /etc/profile.d/custom.sh
echo "  fi" >> /etc/profile.d/custom.sh
echo "fi" >> /etc/profile.d/custom.sh
chmod +x /etc/profile.d/custom.sh
mkdir -p /opt/app/oracle/product/11.2.0
chown -R oracle:oinstall /opt/app
chmod -R 775 /opt/app
echo "umask 022" >> /home/oracle/.bash_profile

echo "export TMPDIR=\$TMP" >> /home/oracle/.bash_profile
echo "ORACLE_HOSTNAME=localhost; export ORACLE_HOSTNAME" >> /home/oracle/.bash_profile
echo "ORACLE_UNQNAME=DB11G; export ORACLE_UNQNAME" >> /home/oracle/.bash_profile
echo "export ORACLE_BASE=/opt/app/oracle" >> /home/oracle/.bash_profile
echo "export ORACLE_HOME=\$ORACLE_BASE/product/11.2.0/db_1" >> /home/oracle/.bash_profile
echo "ORACLE_SID=DB11G; export ORACLE_SID" >> /home/oracle/.bash_profile
echo "PATH=/usr/sbin:\$PATH; export PATH" >> /home/oracle/.bash_profile
echo "export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib" >> /home/oracle/.bash_profile
echo "export PATH=\$ORACLE_HOME/bin:\$PATH" >> /home/oracle/.bash_profile
echo "CLASSPATH=\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib; export CLASSPATH export PATH" >> /home/oracle/.bash_profile

chmod 644 /home/oracle/.bash_profile
chown oracle:oinstall /home/oracle/.bash_profile
echo "Please Run vncserver with user oracle to install oracle with vnc remote"
su oracle
