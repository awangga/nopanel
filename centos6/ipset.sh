#!/bin/sh

sed -i 's/ONBOOT=no/ONBOOT=yes/g' /etc/sysconfig/network-scripts/ifcfg-$1
sed -i 's/NM_CONTROLLED=yes/NM_CONTROLLED=no/g' /etc/sysconfig/network-scripts/ifcfg-$1
sed -i 's/BOOTPROTO=dhcp/BOOTPROTO=static/g' /etc/sysconfig/network-scripts/ifcfg-$1
echo "IPADDR=$2" >> /etc/sysconfig/network-scripts/ifcfg-$1
echo "NETMASK=$3" >> /etc/sysconfig/network-scripts/ifcfg-$1
echo "GATEWAY=$4" >> /etc/sysconfig/network-scripts/ifcfg-$1
echo "DNS1=$5" >> /etc/sysconfig/network-scripts/ifcfg-$1