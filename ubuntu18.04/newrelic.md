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

