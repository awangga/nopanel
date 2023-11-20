# Instalation and Upgrade Docker

Secara berkala melakukan upgrade docker ke server terbaru, jalankan pada VM Docker perintah :
```sh
apt list --installed | grep docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Docker Swarm

Untuk mengatur CI CD menggunakan docker swarm menggunakan perintah berikut

## Gitlab Runner

Untuk melakukan CI CD dari repo gitlab maka perintanya adalah
