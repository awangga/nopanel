node='n11'
hostport='80'


docker stop $node
sleep 5
docker rm $node
sleep 5
docker build -t $node:prod .
sleep 5
docker run -d -t -p $hostport:80 --name $node $node:prod

