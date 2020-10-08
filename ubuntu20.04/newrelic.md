# Instalasi Monitoring Menggunakan NewRelic
Tambahkan dulu repositori dan install newrelic:

```sh
wget -O - https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" \
> /etc/apt/sources.list.d/newrelic.list'
sudo apt-get update
sudo apt-get install newrelic-php5
```


untuk berpindah ke versi php yang ingin diinstall gunakan perintah : 

php 5.6

```sh
sudo update-alternatives --set php /usr/bin/php5.6
php -v
```

php 7.1 

```sh
sudo update-alternatives --set php /usr/bin/php7.1
php -v
```

php 7.4 

```sh
sudo update-alternatives --set php /usr/bin/php7.4
php -v
```

Untuk melakukan instalasi newrelic PHP settingan default pada server ketik:

```sh
sudo newrelic-install
```

jangan lupa untuk melakukan setting nama aplikasi atau server pada masing-masing file konfigurasi php dengan perintah :

php 5.6 :

```sh
sudo nano /etc/php/5.6/fpm/conf.d/newrelic.ini
sudo nano /etc/php/5.6/cli/conf.d/newrelic.ini
```

php 7.1 :

```sh
sudo nano /etc/php/7.1/fpm/conf.d/newrelic.ini
sudo nano /etc/php/7.1/cli/conf.d/newrelic.ini
```

php 7.4 : 

```sh
sudo nano /etc/php/7.4/fpm/conf.d/newrelic.ini
sudo nano /etc/php/7.4/cli/conf.d/newrelic.ini
```

ganti PHP Application pada bagian :

newrelic.appname = "PHP Application" 

menjadi versi php dan nama server agar mudah maintenacenya, contoh: "PHP5.6 Croot Poltekpos"

Kemudian jangan lupa untuk restart php-fpm :

```sh
systemctl restart php5.6-fpm
systemctl restart php7.1-fpm
systemctl restart php7.4-fpm
```

opsional jika ingin restart nginx :

```sh
systemctl restart nginx
```

