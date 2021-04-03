#build mysql dan nodejs images
cd ~/DO180/labs/multicontainer-design/images/mysql
sudo podman build -t do180/mysql-57-rhel7 --layers=false .
sudo podman images
cat ../nodejs/Dockerfile
cd ~/DO180/labs/multicontainer-design/images/nodejs
sudo podman build -t do180/nodejs --layers=false .

# Check images and build from source
sudo podman images --format "table {{.ID}} {{.Repository}} {{.Tag}}"
cd ~/DO180/labs/multicontainer-design/deploy/nodejs
cat ./nodejs-source/models/db.js
cat build.sh
sudo ./build.sh
sudo podman images --format "table {{.ID}} {{.Repository}} {{.Tag}}"


cd networked
cat run.sh
#add this in the end of file
#sudo podman run -d --name todoapi -e MYSQL_DATABASE=items -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -p 30080:30080 do180/todonodejs

#run and check
sudo ./run.sh
sudo podman ps --format="table {{.ID}} {{.Names}} {{.Image}} {{.Status}}"
sudo podman exec -it todoapi env
curl -w "\n" http://127.0.0.1:30080/todo/api/items/1


