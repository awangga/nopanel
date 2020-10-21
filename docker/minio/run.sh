node='minio'
hostport='9000'
ipaddr='172.18.0.11'


git pull origin master
sleep 5
docker pull minio/minio:latest
sleep 5
docker stop $node
sleep 5
docker rm $node
sleep 5
#docker run -d -t -p $hostport:9000 --ip $ipaddr -e "MINIO_ACCESS_KEY=AKUANOSFODNN7R7AMPOL" -e "MINIO_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEYAMROLLLY" --name $node minio/minio:latest server /data
docker run -d -t --net apinet \
--restart=unless-stopped \
-h $node \
-v $(pwd)/data:/data \
--add-host minio.viralbisnis.id:172.18.0.11 \
--add-host viralbisnis.minio.viralbisnis.id:172.18.0.11 \
--add-host nats.viralbisnis.id:172.18.0.18 \
-p $hostport:9000 \
--ip $ipaddr \
-e "MINIO_ACCESS_KEY=AKUANOSFODNN7R7AMPOL" \
-e "MINIO_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEYAMROLLLY" \
--name $node \
minio/minio:latest server /data
