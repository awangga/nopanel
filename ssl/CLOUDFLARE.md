Mantap! Karena Anda menggunakan **Cloudflare**, proses mendapatkan sertifikat Let's Encrypt via **DNS-01 challenge otomatis** akan sangat mudah dan bisa 100% tanpa campur tangan manual.

Berikut panduan lengkap dan skrip yang bisa langsung Anda pakai.

---

## ✅ **Langkah-Langkah: Certbot + Cloudflare API (DNS-01)**

### 📦 1. Instal Plugin Certbot Cloudflare

Ubuntu/Debian:

```bash
sudo apt update
sudo apt install certbot python3-certbot-dns-cloudflare
```

---

### 🔐 2. Buat File Credential API Cloudflare

#### A. **Ambil API Key Anda**

* Masuk ke: [https://dash.cloudflare.com/profile/api-tokens](https://dash.cloudflare.com/profile/api-tokens)
* Scroll ke **Global API Key** → Klik **View** dan salin

#### B. **Buat File `cf.ini`**

```bash
sudo mkdir -p /root/.secrets
sudo nano /root/.secrets/cf.ini
```

Isi dengan:

```ini
dns_cloudflare_email = your-email@example.com
dns_cloudflare_api_key = your_global_api_key
```

Simpan, lalu set permission agar aman:

```bash
sudo chmod 600 /root/.secrets/cf.ini
```

---

### 🧪 3. Jalankan Certbot

```bash
sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials /root/.secrets/cf.ini \
  -d server.rangkaian.net
```

> Ganti `server.rangkaian.net` dengan subdomain Anda.

---

### ✅ 4. Sertifikat Akan Tersimpan di:

* `/etc/letsencrypt/live/server.rangkaian.net/fullchain.pem`
* `/etc/letsencrypt/live/server.rangkaian.net/privkey.pem`

Anda bisa langsung pakai untuk Nginx, Apache, atau lainnya.

---

## 🔄 5. Renewal Otomatis

Let’s Encrypt berlaku 90 hari, tapi certbot akan otomatis perpanjang.

Cek:

```bash
sudo certbot renew --dry-run
```

Jika sukses, tambahkan cronjob:

```bash
sudo crontab -e
```

Isi:

```cron
0 3 * * * certbot renew --quiet
```

---

## 🧩 Bonus: Contoh Nginx dengan Sertifikat

```nginx
server {
    listen 443 ssl;
    server_name server.rangkaian.net;

    ssl_certificate     /etc/letsencrypt/live/server.rangkaian.net/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/server.rangkaian.net/privkey.pem;

    location / {
        proxy_pass http://localhost:3000;
    }
}
```

