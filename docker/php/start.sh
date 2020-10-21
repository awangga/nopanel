git clone repo
cd repo
cp .env.example .env
nano .env
nano Dockerfile
mkdir -p docker-compose/nginx
nano docker-compose/nginx/apisuperadmin.conf

####

server {
    listen 80;
    index index.php index.html;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /var/www/public;
    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass app:9000;
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

####

nano docker-compose.yml


######

version: "3.7"
services:
  app:
    build:
      args:
        user: awangga
        uid: 1000
      context: ./
      dockerfile: Dockerfile
    image: apisuperadmin
    container_name: apisuperadmin-app
    restart: unless-stopped
    working_dir: /var/www/
    volumes:
      - ./:/var/www
    networks:
      - apisuperadmin

  nginx:
    image: nginx:alpine
    container_name: apisuperadmin-nginx
    restart: unless-stopped
    ports:
      - 80:80
    volumes:
      - ./:/var/www
      - ./docker-compose/nginx:/etc/nginx/conf.d/
    networks:
      - apisuperadmin

networks:
  apisuperadmin:
    driver: bridge

#####


docker-compose build app
docker-compose up -d
docker-compose ps
