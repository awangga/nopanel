# siti
sistem akademik tipu tipu karena menggunakan teknologi lama PHP 5.1

## Instalasi program pendukung
Pastikan stop dahulu aplikasi web server sebelumnya 

```sh
systemctl stop apache2
systemctl disable apache2
```

Instalasi nginx dan php 5.6
```sh
#nginx install
sudo apt install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx

#add php repository and install php
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update	

#php 5.6
sudo apt install php5.6-fpm php5.6-mbstring php5.6-xml php5.6-mysql php5.6-common php5.6-gd php5.6-json php5.6-cli php5.6-curl php5.6-zip php5.6-intl php5.6-xmlrpc php5.6-soap
sudo systemctl start php5.6-fpm
sudo systemctl status php5.6-fpm
sudo systemctl enable php5.6-fpm
```

buat konfigurasi nginx dengan perintah :

```sh
nano /etc/nginx/sites-enabled/siap
```

yang berisi :

```sh
server {
        server_name  siap.poltekpos.ac.id;

        root   /var/www/html/siap;
        index  index.php index.html index.htm;

        location / {
                try_files $uri $uri/ /index.php?$args;
        }

		location /simpati/siap/ {
                rewrite ^/simpati/siap/(.*)$ /simpati/siap/index.php?/$1;
        }



		location ~ ^(.+\.php)(.*)$ {
			set $path_info $fastcgi_path_info;
			fastcgi_split_path_info ^(.+\.php)(.*)$;
			fastcgi_param PATH_INFO $path_info;
			fastcgi_param PATH_TRANSLATED $document_root$path_info;

			if (!-f $document_root$fastcgi_script_name) {
				return 404;
			}
			include fastcgi_params;

			fastcgi_pass unix:/var/run/php/php5.6-fpm.sock;
			fastcgi_index index.php;
			fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
			fastcgi_buffers 16 16k;
			fastcgi_buffer_size 32k;
		}
}
```

restart nginx :

```sh
sudo systemctl reload nginx
sudo systemctl restart nginx
```

instalasi https:

```sh
sudo add-apt-repository universe && sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update && sudo apt-get install certbot python-certbot-nginx


sudo certbot --nginx
```

Kemudian untuk pembaharuan otomatis ssl :

```sh
sudo crontab -e
30 2 * * * certbot renew
```

## Database
config database ada di dua file :
1. siap/modul/simpati/simpati.koneksi.php
2. siap/modul/simpati/simpati.koneksi.import.php
3. siap/besan.config.php
4. ci-app/simpati/config/database.php hanya pada blok['poltekpos']

## Upgrade Codeigniter module
Edit pada baris 257 file :
ci-system/core/Common.php

```php
//		return $_config[0] =& $config;
//baris 257 ubah menjadi 2 baris
$_config[0] =& $config;
return $_config[0];
```
## Trigger
permasalahan nanti "the user specified as a definer ('root'@'%') does not exist"
solusi:
1. jalankan query dengan user root
``` SET GLOBAL log_bin_trust_function_creators = 1; ```
3. buat ulang trigger pada table simak_besan_users. tinggal contoh trigger st_user_insert_after dan st_user_update_after yang telah ada sebelumnya.
