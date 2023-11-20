# Instalation and Upgrade Docker

Secara berkala melakukan upgrade docker ke server terbaru, jalankan pada VM Docker perintah :
```sh
apt list --installed | grep docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
![WhatsApp Image 2023-11-20 at 09 55 44_d1ca862d](https://github.com/awangga/nopanel/assets/11188109/0656932a-ebc6-4199-9559-3ed5b99483db)

## Docker Swarm

Untuk mengatur CI CD menggunakan docker swarm menggunakan perintah berikut

### Untuk x86-64
```sh
sudo curl -L --output /usr/local/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64"

sudo chmod +x /usr/local/bin/gitlab-runner

sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner

sudo gitlab-runner start
```

## Gitlab Runner

Untuk menambahkan runner ke project  
```sh
gitlab-runner register  --url https://gitlab.com  --token <TOKEN GITLAB>
```