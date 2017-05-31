#!/bin/bash

sudo apt-get install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo sed -i 's/bantime  = 600/bantime  = 31536000/g' /etc/fail2ban/jail.local
sudo systemctl restart fail2ban