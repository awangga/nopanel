# Install SSL


## Persiapkan Virtual Host

```sh
mkdir -p /var/www/kumah.asia/html
nano /var/www/kumah.asia/index.html
```

isi index.html

```sh
nano /etc/nginx/sites-available/kumah.asia.conf
```

isi dengan:
```conf
server {
        listen 80;
        listen [::]:80;

        root /var/www/kumah.asia;
        index index.html index.htm index.nginx-debian.html;

        server_name kumah.asia  www.kumah.asia;

        location / {
                try_files $uri $uri/ =404;
        }
}
```

enable virtualhost
```sh
ln -s /etc/nginx/sites-available/kumah.asia.conf   /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx
```

## install certbot

pakai root
```sh
apt install certbot python3-certbot-nginx
certbot --nginx -d domain.info
```
