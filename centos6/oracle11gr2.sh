#/bin/sh

## Unzip Oracle installer
pushd /tmp
unzip linux.x64_11gR2_database_1of2.zip
unzip linux.x64_11gR2_database_2of2.zip
popd

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

echo "Create oracle home profile"
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
echo "export ORACLE_HOME_LISTNER=LISTENER" >> /home/oracle/.bash_profile

echo "Create oracle guided installer for user oracle"
echo "echo \"PLease Make Sure This Settings : \"" >> /home/oracle/installOracle.sh
echo "echo \"1. Install database software only\"" >> /home/oracle/installOracle.sh
echo "echo \"2. Single instance database installation\"" >> /home/oracle/installOracle.sh
echo "echo \"3. English Language\"" >> /home/oracle/installOracle.sh
echo "echo \"4. Enterprise Edition\"" >> /home/oracle/installOracle.sh
echo "echo \"5. verify Oracle Base: '/opt/app/oracle'\"" >> /home/oracle/installOracle.sh
echo "echo \"6. verify Oracle Home: '/opt/app/oracle/product/11.2.0/db_1'\"" >> /home/oracle/installOracle.sh
echo "echo \"7. Verify path of inventory directory: '/opt/app/oraInventory'\"" >> /home/oracle/installOracle.sh
echo "echo \"8. verify group name for install of 'oinstall'\"" >> /home/oracle/installOracle.sh
echo "echo \"9. Prerequisite Checks: Ignore All\"" >> /home/oracle/installOracle.sh
echo "echo \"10. validate 'Global Settings'\"" >> /home/oracle/installOracle.sh
echo "echo \"11. validate 'Space Requirements'\"" >> /home/oracle/installOracle.sh
echo "echo \"12. Execute configuration scripts\"" >> /home/oracle/installOracle.sh
echo "echo \"13. clean up\"" >> /home/oracle/installOracle.sh
echo "cd /tmp" >> /home/oracle/installOracle.sh
echo "./runInstaller " >> /home/oracle/installOracle.sh
echo "cd" >> /home/oracle/installOracle.sh
echo "source .bash_profile" >> /home/oracle/installOracle.sh
echo "echo \"Create Oracle Listener, leave default name LISTENER TCP Port 1521\"" >> /home/oracle/installOracle.sh
echo "netca" >> /home/oracle/installOracle.sh
echo "lsnrctl status LISTENER" >> /home/oracle/installOracle.sh
echo "tnsping localhost 1521" >> /home/oracle/installOracle.sh
echo "echo \"Create Oracle Database, Settings:\"" >> /home/oracle/installOracle.sh
echo "echo \"1. Create a database\"" >> /home/oracle/installOracle.sh
echo "echo \"2. General Purpose or transaction Processing\"" >> /home/oracle/installOracle.sh
echo "echo \"3. Global Database Name & SID : DB11G\"" >> /home/oracle/installOracle.sh
echo "echo \"4. Thick Configure Enterprise Manager & Choose Configure Database Control for local management\"" >> /home/oracle/installOracle.sh
echo "echo \"5. Use the Same Administrative Password for All Accounts\"" >> /home/oracle/installOracle.sh
echo "echo \"6. File System\"" >> /home/oracle/installOracle.sh
echo "echo \"7. Use Database file Location from Template\"" >> /home/oracle/installOracle.sh
echo "echo \"8. default settings on Recovery Configuration\"" >> /home/oracle/installOracle.sh
echo "echo \"9. enhanced 11g default security\"" >> /home/oracle/installOracle.sh
echo "echo \"10. Thick Automatic Maintenance Tasks\"" >> /home/oracle/installOracle.sh
echo "echo \"11. defaults Database Storage\"" >> /home/oracle/installOracle.sh
echo "echo \"12. Create Database\"" >> /home/oracle/installOracle.sh
echo "dbca" >> /home/oracle/installOracle.sh
echo "sed -i 's/:N/:Y/g' /etc/oratab" >> /home/oracle/installOracle.sh
echo "dbstart \$ORACLE_HOME" >> /home/oracle/installOracle.sh
echo "emctl start dbconsole" >> /home/oracle/installOracle.sh
echo "echo \"go to sqlplus to check : select * from dual;\"" >> /home/oracle/installOracle.sh
echo "sqlplus sys@demo AS SYSDBA" >> /home/oracle/installOracle.sh
echo "echo \"Done\"" >> /home/oracle/installOracle.sh


echo "Create oracle service auto start"
cp oracle /etc/init.d/
chmod +x /etc/init.d/oracle
sudo chkconfig --add oracle
chkconfig --list oracle


iptables -I INPUT -p tcp --dport 1521 -j ACCEPT
iptables -I INPUT -p tcp --dport 5901 -j ACCEPT
iptables -I INPUT -p tcp --dport 1158 -j ACCEPT
service iptables save
/etc/init.d/iptables restart

chmod 644 /home/oracle/.bash_profile
chown oracle:oinstall /home/oracle/.bash_profile
chown oracle:oinstall /home/oracle/installOracle.sh
chmod a+x /home/oracle/installOracle.sh
echo "Please Run command : vncpassword then vncserver with user oracle, after than remote with vnc and start ./installOracle.sh"
su oracle
