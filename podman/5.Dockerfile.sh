#build from Dockerfile
sudo podman build --layers=false -t do180/apache .

# check and run
sudo podman images
sudo podman run --name lab-apache -d -p 10080:80 do180/apache