node='n21'
#hostport='7106'
ipaddr='172.18.0.14'


git pull origin master
sleep 5
cp ./src/config.json.prod ./src/config.json
sleep 5
docker run --rm -v $(pwd):/app --name composer composer install
sleep 5
docker build -t $node:prod .
sleep 5
docker stop $node
sleep 5
docker rm $node
sleep 5
docker run -d -t --net apinet \
--restart=unless-stopped \
-h $node \
--add-host minio.viralbisnis.id:172.18.0.11 \
--add-host viralbisnis.minio.viralbisnis.id:172.18.0.11 \
--add-host nats.viralbisnis.id:172.18.0.18 \
-p $hostport:80 \
--ip $ipaddr \
--name $node \
$node:prod
sleep 5
#curl localhost:$hostport
#docker exec -it $node composer install
docker exec -it $node cat /etc/hosts

