# Preparation

## Download and Unzip Oracle Installer
put your oracle downloaded installer in /tmp

## Setting IP
```sh
# ./ipset.sh eth0 192.168.1.100 255.255.255.0 192.168.1.1 192.168.1.1
```

## Run Script

```sh
# ./oracle11gr2.sh
```

## Oracle Installation

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