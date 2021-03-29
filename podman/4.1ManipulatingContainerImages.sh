sudo podman login quay.io
sudo podman run -d --name official-httpd -p 8180:80 redhattraining/httpd-parent
sudo podman exec -it official-httpd /bin/bash
# echo "DO180 Page" > /var/www/html/do180.html
#exit
curl 127.0.0.1:8180/do180.html

#Retrieve the list of external files and directories that Podman mounts to the running container:
sudo podman inspect -f "{{range .Mounts}}{{println .Destination}}{{end}}" official-httpd
#Execute the podman diff command to see a list of modified files in the container file system:
sudo podman diff official-httpd

#Create a new image with the changes created by the running container.
sudo podman stop official-httpd
sudo podman commit -a 'Your Name' official-httpd do180-custom-httpd
sudo podman images


#Publish the saved container image to the container registry.
#Run the following command to load the environment variables created in the first guided exercise cuman buat replace variabel doang:
source /usr/local/etc/ocp4.config
#kasih tag biar official bukan localhost lagi
sudo podman tag do180-custom-httpd quay.io/${RHT_OCP4_QUAY_USER}/do180-custom-httpd:v1.0
sudo podman images
sudo podman push quay.io/${RHT_OCP4_QUAY_USER}/do180-custom-httpd:v1.0

#pull and run image
sudo podman pull -q quay.io/${RHT_OCP4_QUAY_USER}/do180-custom-httpd:v1.0\
sudo podman run -d --name test-httpd -p 8280:80 ${RHT_OCP4_QUAY_USER}/do180-custom-httpd:v1.0
curl http://localhost:8280/do180.html