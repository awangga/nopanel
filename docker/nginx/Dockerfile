FROM nginx:alpine

WORKDIR /var/www/html


COPY . .
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY app.conf /etc/nginx/conf.d/


EXPOSE 80
