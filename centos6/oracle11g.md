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
sed -i 's/ONBOOT=no/ONBOOT=yes/g' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i 's/NM_CONTROLLED=yes/NM_CONTROLLED=no/g' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i 's/BOOTPROTO=dhcp/BOOTPROTO=static/g' /etc/sysconfig/network-scripts/ifcfg-eth0
echo 'IPADDR=192.168.100.100' >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo 'NETMASK=255.255.255.0' >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo 'GATEWAY=192.168.100.1' >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo 'DNS1=192.168.100.1' >> /etc/sysconfig/network-scripts/ifcfg-eth0

## Run Script

```sh
# cd nopanel/centos6/
# ./oracle11gr2.sh
```
## Oracle Installation
$ unzip linux.x64_11gR2_database_1of2.zip
$ unzip linux.x64_11gR2_database_2of2.zip
Please use vnc to login and run ./runInstaller from oracle user

Optionally specify email address to be informed about security issues
Choose "Install database software only", click "Next"
Choose "Single instance database installation", click "Next"
Add another language besides of English if you wish, click "Next"
Choose 'Enterprise Edition' and on "Select options" choose the components you wish to install, click "Next"

Set the following settings and click "Next":
verify Oracle Base: '/opt/app/oracle'
verify Oracle Home: '/opt/app/oracle/product/11.2.0/db_1'
Verify path of inventory directory: '/opt/app/oraInventory'  and 
verify group name for install of 'oinstall', click "Next" 
Prerequisite Checks:  the installer will verify the system environment and report on any issues it may find. If all goes well you will get the status of 'Succeeded' for every check. You have to check 'Ignore All' but ensure at least that the following checks pass: 
Physical memory (also Available)
Free space
User and groups existence
Group membership
Hard and soft limits
Architecture
Kernel version
OS Kernel parameters
Swap size
Run level.
Packages
Users with same ID

Summary: This screen give a summary of the installation you are about to perform. Click and expand the products being installed to give you an idea of the what product and version is going to be installed.
validate 'Global Settings' for directories
validate 'Space Requirements'
Click NEXT

Install: This screen gives a status of what is being installed. If all system settings have been properly set and all packages been installed properly then this should proceed without error. 
Note the time it takes for specific products. If you notice one hanging or taking a long amount of time (greater than 10 minutes) you could have a condition that requires a pre-installation patch. Don't stop the installer yet but instead start looking for a bug / patch for the Oracle 11g installation process and the actual product being installed.
Execute configuration scripts, when the wizard ask it:
open up a different terminal window
login as the admin or root user
run:
$ sudo /opt/app/oraInventory/orainstRoot.sh
$ sudo /opt/app/oracle/product/11.2.0/db_1/root.sh
accept a default of /usr/local/bin
click OK

Cleanup: If you downloaded the software from the net you can now remove .zip file and the complete directory structure you unzipped it to.


http://eduardo-lago.blogspot.co.id/2012/01/how-to-install-oracle-11g-database.html