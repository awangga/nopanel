Bagus! **DNS-01 challenge** adalah cara paling fleksibel dan aman untuk mendapatkan sertifikat **tanpa IP publik**, selama Anda bisa mengelola DNS domain Anda (misalnya di Cloudflare, Namecheap, IDCloudHost, dll).

---

## ✅ Tujuan Akhir

Anda akan mendapatkan sertifikat SSL Let's Encrypt untuk domain seperti `server.rangkaian.net` tanpa membuka port atau mengandalkan hosting pihak ketiga.

---

## 🛠️ Dua Pilihan:

### 🔹 **A. Manual DNS-01 Challenge** (jika tidak ada API DNS provider)

### 🔹 **B. Otomatis DNS-01 dengan API** (misalnya pakai Cloudflare)

---

## 🔹 A. **Manual DNS-01 Challenge** (paling dasar, tanpa API)

### 1. Jalankan Certbot:

```bash
sudo certbot certonly --manual --preferred-challenges dns -d server.rangkaian.net
```

### 2. Certbot akan memberikan instruksi seperti ini:

```
Please deploy a DNS TXT record under the name
_acme-challenge.server.rangkaian.net with the following value:

wK3k9f_example_token_xRj

Before continuing, verify the record is deployed.
```

### 3. Masuk ke DNS panel domain Anda → Tambah record:

| Tipe | Nama (subdomain)         | Nilai                      |
| ---- | ------------------------ | -------------------------- |
| TXT  | `_acme-challenge.server` | `wK3k9f_example_token_xRj` |

**Tunggu \~1-5 menit** agar record DNS menyebar (gunakan tools seperti [https://dnschecker.org](https://dnschecker.org)).

### 4. Tekan `Enter` di Certbot setelah record tersedia.

### 5. Jika berhasil, sertifikat ada di:

* `/etc/letsencrypt/live/server.rangkaian.net/fullchain.pem`
* `/etc/letsencrypt/live/server.rangkaian.net/privkey.pem`

---

## 🔹 B. **Otomatis: Certbot + Cloudflare API (jika domain Anda di Cloudflare)**

Jika domain Anda di Cloudflare, proses bisa **otomatis 100%**.

### 1. Instal plugin DNS Cloudflare:

```bash
sudo apt install python3-certbot-dns-cloudflare
```

### 2. Buat file API credentials:

Buat file: `/root/.secrets/cf.ini`

```ini
dns_cloudflare_email = your-email@example.com
dns_cloudflare_api_key = your_global_api_key
```

Ganti permission:

```bash
chmod 600 /root/.secrets/cf.ini
```

> 🔑 Anda bisa dapatkan `API key` dari: [https://dash.cloudflare.com/profile/api-tokens](https://dash.cloudflare.com/profile/api-tokens)

### 3. Jalankan certbot:

```bash
sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials /root/.secrets/cf.ini \
  -d server.rangkaian.net
```

> Bisa digunakan untuk subdomain mana saja yang dikelola oleh Cloudflare.

---

## 🔄 Renewal Otomatis

Let's Encrypt valid 90 hari. Renewal:

```bash
sudo certbot renew
```

Jika pakai DNS API seperti Cloudflare, renewal otomatis 100%.

Tambahkan cronjob (opsional):

```bash
sudo crontab -e
```

```cron
0 3 * * * certbot renew --quiet
```

---

## 🔐 Setelah Sertifikat Siap

Anda tinggal gunakan di web server lokal:

Contoh konfigurasi Nginx:

```nginx
server {
    listen 443 ssl;
    server_name server.rangkaian.net;

    ssl_certificate     /etc/letsencrypt/live/server.rangkaian.net/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/server.rangkaian.net/privkey.pem;

    location / {
        proxy_pass http://localhost:3000;  # atau layanan lokal Anda
    }
}
```