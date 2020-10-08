sudo apt-get update && sudo apt-get install software-properties-common
sudo add-apt-repository universe && sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update && sudo apt-get install certbot python-certbot-nginx


sudo certbot --nginx

#for renewal
sudo certbot renew --dry-run
sudo certbot renew