FROM romeoz/docker-nginx-php:7.3

RUN mkdir /root/natsclient
RUN apt-get update && apt-get install -y git

WORKDIR /root/natsclient

# Get latest Composer
#COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


COPY . .
COPY ./docker-compose/supervisord/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#CMD ["/root/natsclient/startd.sh"]

