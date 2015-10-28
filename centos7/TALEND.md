#Talend ESB Installation

## Pre Install
 1. Instal JDK
 yum install java-1.7.0-openjdk
 yum install java-1.7.0-openjdk-devel
 2. create user for talend
 adduser talend
 3. set environment
 echo export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.91-2.6.2.1.el7_1.x86_64 >> /etc/environment
 echo export JDK_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.91-2.6.2.1.el7_1.x86_64 >> /etc/environment
 echo export PATH=$JDK_HOME/bin:$PATH >> /etc/environment
 echo export PATH=$JAVA_HOME/bin:$PATH >> /etc/environment
 4. unzip esb
 unzip esb.zip
 5. Change directory to container bin 
 cd Runtime_ESBSE/container/bin
 6. Open port on firewalld
 firewall-cmd --permanent --zone=public --add-port=8040/tcp
 firewall-cmd --permanent --zone=public --add-port=9001/tcp
 firewall-cmd --reload
 firewall-cmd --zone=public --list-all

## Run
```sh
$ cd Runtime_ESBSE/container/bin
$ ./start
```

## Install as service
```sh
$ ./trun
karaf@trun()> feature:install wrapper
karaf@trun()> wrapper:install
ctrl+d
$ su
# ln -s /home/talend/Runtime_ESBSE/container/bin/karaf-service /etc/init.d/
# chkconfig karaf-service --add
# chkconfig karaf-service on
# exit
$ service karaf-service start
```

## Running worker with nohup
```sh
nohup sh /home/talend/Runtime_ESBSE/container/deploy/standalone/sms_worker/pon_02w_sms/pon_02w_sms_run.sh &
```

## Reference 
 1. https://www.digitalocean.com/community/tutorials/how-to-install-java-on-centos-and-fedora