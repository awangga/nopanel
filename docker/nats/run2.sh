node='nats2'
ipaddr='172.18.0.19'

docker stop $node
sleep 5
docker rm $node
sleep 5
docker run -d -t --net apinet \
--restart=unless-stopped \
-h $node \
--ip $ipaddr \
--name $node \
nats-streaming \
-p 4223 -m 8223 \
-cid b \
--cluster nats://0.0.0.0:6223 \
--routes nats-route://l72.18.0.18:6223,nats-route://172.18.0.20:6223 \
--cluster_node_id b \
--cluster_peers a,c

