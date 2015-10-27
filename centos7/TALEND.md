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
 
 
 
## Reference 
 1. https://www.digitalocean.com/community/tutorials/how-to-install-java-on-centos-and-fedora