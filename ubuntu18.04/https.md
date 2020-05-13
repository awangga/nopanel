# Instalasi HTTPS
Tambahkan dulu repositori:

```sh
sudo add-apt-repository universe && sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update && sudo apt-get install certbot python-certbot-nginx
```

Untuk melakukan instalasi https pada domain ketik:

```sh
sudo certbot --nginx
```
pastikan memilih opsi auto redirect/pilihan 2

Kemudian untuk pembaharuan otomatis https maka pasang crontab :

```sh
sudo crontab -e
```

isi dari file crontab tersebut dengan:
```sh
30 2 * * * certbot renew
```
