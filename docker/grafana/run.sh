node='grafana'
hostport='3000'
ipaddr='172.18.0.88'


git pull origin master
sleep 5
docker pull minio/minio:latest
sleep 5
docker stop $node
sleep 5
docker rm $node
sleep 5


docker run -d --net apinet \
--restart=unless-stopped \
-h $node \
-p $hostport:3000 \
--ip $ipaddr \
-e "GF_SECURITY_ADMIN_PASSWORD=rollyganteng" \
-e "GF_USERS_ALLOW_SIGN_UP=false" \
-e "GF_SMTP_ENABLED=true" \
-e "GF_SMTP_HOST=smtp.gmail.com:587" \
-e "GF_SMTP_USER=awangga@apps.vas.web.id" \
-e "GF_SMTP_PASSWORD=rollygantengsekali" \
-e "GF_SMTP_FROM_ADDRESS=awangga@apps.vas.web.id" \
--name $node \
grafana/grafana

