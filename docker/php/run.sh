node='n21'
hostport='7106'
ipaddr='172.18.0.14'


git pull origin master
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
--ip $ipaddr \
--name $node \
$node:prod


