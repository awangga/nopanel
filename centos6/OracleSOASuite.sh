#/bin/sh
## PLease install oracle JDK first, JDK 8 supported
## Create sudoers

useradd admin
echo "user admin password set"
passwd admin
echo '%admin   ALL=(ALL)   ALL' > /etc/sudoers.d/admin

## run vncserver
#yum -y install java-1.7.0-openjdk
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
echo "export CONFIG_JVM_ARGS=\"-Djava.security.egd=file:/dev/./urandom\"" >> /home/oracle/.bash_profile
echo "export MW_HOME=/opt/app/oracle/Oracle/Middleware" >> /home/oracle/.bash_profile
#echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.141.x86_64/jre/" >> /home/oracle/.bash_profile




echo "Create SOA Suite Installer" >>
echo "echo \"WebLogic Instalation,Make Sure This Settings : \"" >> /home/oracle/soainstall.sh
echo "echo \"1. change direktori to /opt/app/oracle/Oracle/Middleware, this machine no internet access\"" >> /home/oracle/soainstall.sh
echo "echo \"2. custom installation\"" >> /home/oracle/soainstall.sh
echo "echo \"3. install all component, except server examples and evaluation examples\"" >> /home/oracle/soainstall.sh
echo "echo \"4. Choose Installed JDK on system\"" >> /home/oracle/soainstall.sh
echo "echo \"5. Next\"" >> /home/oracle/soainstall.sh
echo "echo \"6. uncheck Run Quickstart\"" >> /home/oracle/soainstall.sh
echo "cd /tmp" >> /home/oracle/soainstall.sh
echo "java -jar wls1036_generic.jar" >> /home/oracle/soainstall.sh

echo "echo \"SOA Suite Instalation,Make Sure This Settings : \"" >> /home/oracle/soainstall.sh
echo "echo \"1. Verify path of inventory directory: '/opt/app/oraInventory'\"" >> /home/oracle/soainstall.sh
echo "echo \"2. run as root /opt/app/oraInventory/createCentralInventory.sh \"" >> /home/oracle/soainstall.sh
echo "echo \"3. skip Software Update\"" >> /home/oracle/soainstall.sh
echo "echo \"4. Oracle Middleware Home /opt/app/oracle/Oracle/Middleware\"" >> /home/oracle/soainstall.sh
echo "echo \"5. WebLogic Server\"" >> /home/oracle/soainstall.sh
echo "cd /tmp" >> /home/oracle/soainstall.sh
echo "Disk1/runInstaller -jreLoc /usr/lib/jvm/jre-1.7.0-openjdk.x86_64/jre/" >> /home/oracle/soainstall.sh
#echo "ln -s /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.141.x86_64/jre/bin/ /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.141.x86_64/bin" >> /home/oracle/soainstall.sh
#echo "ln -s /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.141.x86_64/jre/lib/ /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.141.x86_64/lib" >> /home/oracle/soainstall.sh
#echo "mv /usr/lib64/libnssutil3.so /usr/lib64/libnssutil3.so.0.0" >> /home/oracle/soainstall.sh
#echo "ln -s /usr/lib64/libnssutil3.so.0.0 /usr/lib64/libnssutil3.so.0" >> /home/oracle/soainstall.sh
#echo "ln -s /usr/lib64/libnssutil3.so.0.0 /usr/lib64/libnssutil3.so" >> /home/oracle/soainstall.sh

echo "echo \"SOA Suite Configuration,Make Sure This Settings : \"" >> /home/oracle/soainstall.sh
echo "echo \"1. Create A New Web Logic Domain\"" >> /home/oracle/soainstall.sh
echo "echo \"2. check BPM Suite, SOA Suite, EM, WSM PM, JRF, WebLogic AWS for JAX-RPC Ext and WS Ext\"" >> /home/oracle/soainstall.sh
echo "echo \"3. Domain Name Set, and other defaults\"" >> /home/oracle/soainstall.sh
echo "echo \"4. set user pass for weblogic\"" >> /home/oracle/soainstall.sh
echo "echo \"5. Choose development mode, and choose jdk\"" >> /home/oracle/soainstall.sh
echo "echo \"6. Pick SOA MDS Schema, and set your oracle server\"" >> /home/oracle/soainstall.sh
echo "$MW_HOME/Oracle_SOA1/common/bin/config.sh" >> /home/oracle/soainstall.sh


iptables -I INPUT -p tcp --dport 7001 -j ACCEPT
iptables -I INPUT -p tcp --dport 5901 -j ACCEPT
iptables -I INPUT -p tcp --dport 8001 -j ACCEPT
service iptables save
/etc/init.d/iptables restart

chmod 644 /home/oracle/.bash_profile
chown oracle:oinstall /home/oracle/.bash_profile
chown oracle:oinstall /home/oracle/installOracle.sh
chown oracle:oinstall /home/oracle/soainstall.sh
chmod a+x /home/oracle/installOracle.sh
chmod a+x /home/oracle/soainstall.sh


echo "Please Run command : vncpassword then vncserver with user oracle"
su oracle
