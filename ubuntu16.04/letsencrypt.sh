/Users/awangga/anaconda/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin




sudo apt-get install letsencrypt
sudo letsencrypt certonly --webroot -w /var/www/html -d www.tukang.review
sudo letsencrypt renew --dry-run --agree-tos

echo "Add this location inside server block under default file"
location ~ /.well-known {
                allow all;
                default_type "text/plain";
                root /var/www/html;
        }


server {
        listen 443 ssl;
       root /var/www/apps/doc/public;
        index index.php index.html index.htm index.nginx-debian.html;
        server_name menu.halaman.download;
        ssl_certificate /etc/letsencrypt/archive/www.halaman.download/fullchain1.pem;
        ssl_certificate_key /etc/letsencrypt/archive/www.halaman.download/privkey1.pem;
        location / {
                try_files $uri $uri/ /index.php?_url=$uri&$args;
        }
        location ~ \.php$ {
                fastcgi_pass unix:/run/php/php7.0-fpm.sock;
                fastcgi_index /index.php;
        include fastcgi_params;
        fastcgi_split_path_info       ^(.+\.php)(/.+)$;
        fastcgi_param PATH_INFO       $fastcgi_path_info;
        fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
        location ~ /\.ht {
                deny all;
        }
}



server {
        listen 443 ssl;

        server_name example.com;
        ssl_certificate /etc/nginx/ssl/nginx.crt;
        ssl_certificate_key /etc/nginx/ssl/nginx.key;

        location / {
            proxy_pass http://127.0.0.1:80;
            proxy_set_header X-Real-IP  $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto https;
            proxy_set_header X-Forwarded-Port 443;
            proxy_set_header Host $host;
        }
}


echo "Add to crontab"
15 3 * * * letsencrypt renew --dry-run --agree-tos