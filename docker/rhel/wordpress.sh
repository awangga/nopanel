#add repo and install docker on rhel 8
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf list docker-ce
dnf install docker-ce --nobest -y
systemctl status docker
systemctl start docker
systemctl enable docker


docker search hello
docker pull hello-world
docker image ls
docker container run hello-world

#pull image mariadb and wordpress
docker search mariadb
docker pull mariadb
docker search wordpress
docker pull wordpress
docker image ls

#create persistent volume for mariadb
mkdir -p /root/var/lib/mysql
mkdir -p /root/var/www/html
ls -lR /root/var

#create network docker
docker network ls
docker network create --attachable mariadb-wp-privnet
docker network ls

#run container
docker container run -d --name wordpressdb \
-e MYSQL_ROOT_PASSWORD='redhat' \
-e MYSQL_DATABASE='wordpress' \
-e MYSQL_USER='wordpress' \
-e MYSQL_PASSWORD='redhat' \
-v /root/var/lib/mysql:/var/lib/mysql \
--network mariadb-wp-privnet \
mariadb

docker container run -d \
--name wordpress \
-e WORDPRESS_DB_HOST=wordpressdb \
-e WORDPRESS_DB_USER='wordpress' \
-e WORDPRESS_DB_PASSWORD='redhat' \
-e WORDPRESS_DB_NAME='wordpress' \
-v /root/var/www/html:/var/www/html \
--network mariadb-wp-privnet \
-p 80:80 \
wordpress

docker container ls

#testing
curl -L http://localhost|grep -i welcome


#open firewall
setenforce 0
getenforce
sestatus
vi /etc/selinux/config
#SELINUX=permissive

firewall-cmd --get-active-zones
firewall-cmd --list-services
firewall-cmd --permanent --add-service=http
firewall-cmd –reload
firewall-cmd --list-services


