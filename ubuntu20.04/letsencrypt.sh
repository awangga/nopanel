sudo apt install certbot python3-certbot-nginx

sudo certbot --nginx

#for renewal
sudo certbot renew --dry-run
sudo certbot renew