#Ubuntu Firewall

sudo ufw deny from 192.168.1.1 to any port 3306
sudo ufw allow 60606
sudo ufw allow http
sudo ufw allow https
sudo ufw enable
sudo ufw status numbered
sudo ufw allow from 192.168.1.209
sudo ufw allow from 192.168.1.223
sudo ufw allow from 192.168.1.222
