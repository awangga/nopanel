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
```sh
# su oracle
$ vncpassword
$ vncserver
```
Login to desktop with vnc client and open terminal run 

$ ./installOracle.sh