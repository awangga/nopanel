# Built and deploy

nano Dockerfile
```sh
FROM romeoz/docker-nginx-php:7.3

RUN rm /etc/nginx/sites-enabled/app.conf

COPY . .
COPY --chown=www-data:www-data . /var/www
COPY ./docker-compose/nginx/app.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www

EXPOSE 80
```
mkdir docker-compose && mkdir docker-compose/nginx
nano docker-compose/nginx/app.conf
```sh
server {
    listen 80;
    index index.php index.html;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /var/www/public;
    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
    location / {
        try_files $uri $uri/ /index.php?$query_string;
        gzip_static on;
    }
}
```

nano run.sh
```sh
node='n9'
hostport='7009'

docker stop $node
sleep 5
docker rm $node
sleep 5
docker build -t $node:prod .
sleep 5
docker run -d -t -p $hostport:80 --name $node $node:prod
sleep 5
curl localhost:$hostport
docker exec -it $node composer install
```


simple run
```sh
mkdir docker-compose && mkdir docker-compose/nginx && cp ~/run.sh . && cp ~/Dockerfile . && cp ~/app.conf ./docker-compose/nginx/ && cp .env.example .env && nano run.sh && ./run.sh && git add . && git commit -m "updates" && git push origin master

```

generate key
```sh
docker exec -it n12 php artisan key:generate
docker exec -it n13 php artisan key:generate
docker exec -it n14 php artisan key:generate
docker exec -it n15 php artisan key:generate
docker exec -it n16 php artisan key:generate
docker exec -it n17 php artisan key:generate
```