# prepare folder for volume mounting
sudo mkdir -pv /var/local/mysql
sudo semanage fcontext -a -t container_file_t '/var/local/mysql(/.*)?'
sudo restorecon -R /var/local/mysql
ls -dZ /var/local/mysql
sudo chown -Rv 27:27 /var/local/mysql
# pull and run mysql image
sudo podman pull rhscl/mysql-57-rhel7

sudo podman run --name persist-db -d -v /var/local/mysql:/var/lib/mysql/data -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 \
-e MYSQL_DATABASE=items -e MYSQL_ROOT_PASSWORD=r00tpa55 rhscl/mysql-57-rhel7

sudo podman ps --format="table {{.ID}} {{.Names}} {{.Status}}"


## network and access connection
sudo podman run --name mysqldb-port -d -v /var/local/mysql:/var/lib/mysql/data -p 13306:3306 -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 \
-e MYSQL_DATABASE=items -e MYSQL_ROOT_PASSWORD=r00tpa55 rhscl/mysql-57-rhel7
sudo podman ps
sudo podman inspect -f '{{ .NetworkSettings.IPAddress }}' mysql-1

mysql -uuser1 -h 127.0.0.1 -pmypa55 -P13306 items < /home/student/DO180/labs/manage-networking/db.sql
mysql -uuser1 -h 127.0.0.1 -pmypa55 -P13306 items -e "SELECT * FROM Item"
# Go to container bash
sudo podman exec -it mysqldb-port /bin/bash
which mysql
mysql -uroot items -e "SELECT * FROM Item"
exit

sudo podman exec -it mysqldb-port /opt/rh/rh-mysql57/root/usr/bin/mysql -uroot items -e "SELECT * FROM Item"

