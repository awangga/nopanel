# Cara Instalasi dan Running

1. Download PHP, tambahkan ke path. Setelah itu install composer
2. Enable PHP Extension
```ini
extension=sodium
extension=curl
extension=sockets
extension=gd
extension=mbstring
```
3. buat file .env dahulu
4. Install Dependensi : `composer install` kemudian generate key: `php artisan key:generate`
5. migrate database: `php artisan migrate`
6. Coba isi dengan data seeder(belum jalan) : `php artisan db:seed` 





## Podman

build 
```sh
sudo podman-compose up -d --build --force-recreate
```

remove
```sh
sudo podman ps -a
sudo podman rm corewebapp
sudo podman pod ps
sudo podman pod rm pod_pamong-desa-core-web-app
```