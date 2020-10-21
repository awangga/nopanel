node='dns'
hostport='8888'
ipaddr='172.18.0.88'


git pull origin master
#cp .env.debug .env
sleep 5
docker build -t $node:prod .
sleep 5
docker stop $node
sleep 5
docker rm $node
sleep 5
docker run -d -t --net apinet --ip $ipaddr --name $node \
-v $(pwd)/etc-pihole:/etc/pihole \
-v $(pwd)/etc-dnsmasq.d:/etc/dnsmasq.d \
-p $hostport:80 \
$node:prod

#sleep 5
#curl localhost:$hostport
#docker exec -it $node composer install
#docker exec -it $node php artisan key:generate
#docker exec -it $node chown -R www-data:www-data /var/www
#docker exec -it $node cat /etc/hosts
