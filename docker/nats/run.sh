node='nats'
hostport='4223'
ipaddr='172.18.0.18'

docker stop $node
sleep 5
docker rm $node
sleep 5
docker run -d -t --net apinet \
--restart=unless-stopped \
-h $node \
-p $hostport:4223 -p 8223:8223 \
--ip $ipaddr \
--name $node \
nats-streaming \
-p 4223 -m 8223 \
-cid a \
--cluster nats://0.0.0.0:6223 \
--routes nats-route://l72.18.0.19:6223,nats-route://172.18.0.20:6223 \
--cluster_node_id a \
--cluster_peers b,c



