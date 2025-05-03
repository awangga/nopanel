Berikut adalah **skrip bash otomatis** untuk:

* Instal Certbot + plugin Cloudflare
* Menyiapkan file API `cf.ini`
* Menjalankan Certbot dengan DNS-01 challenge via Cloudflare
* (Opsional) Menambahkan cron untuk auto-renew

---

## ✅ Bash Script: `setup_certbot_cloudflare.sh`

```bash
#!/bin/bash

DOMAIN="server.rangkaian.net"
EMAIL="your-email@example.com"
CF_API_KEY="your_cloudflare_global_api_key"

# === Instalasi Certbot dan plugin Cloudflare ===
echo "🛠️  Installing Certbot and Cloudflare DNS plugin..."
sudo apt update
sudo apt install -y certbot python3-certbot-dns-cloudflare

# === Membuat file credential ===
echo "🔐  Creating Cloudflare credential file..."
mkdir -p /root/.secrets
CRED_FILE="/root/.secrets/cf.ini"

cat <<EOF > "$CRED_FILE"
dns_cloudflare_email = $EMAIL
dns_cloudflare_api_key = $CF_API_KEY
EOF

chmod 600 "$CRED_FILE"
echo "✅  Credential file created at $CRED_FILE"

# === Jalankan certbot dengan DNS challenge ===
echo "🔄  Running Certbot to obtain certificate for $DOMAIN..."
certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials "$CRED_FILE" \
  -d "$DOMAIN"

# === Tambah cronjob untuk renewal ===
echo "⏰  Adding cronjob for automatic renewal..."
( crontab -l 2>/dev/null; echo "0 3 * * * certbot renew --quiet" ) | crontab -

echo "✅ Done. Your certificate is at /etc/letsencrypt/live/$DOMAIN/"
```

---

## 📌 Cara Pakai:

1. **Edit terlebih dahulu baris-baris ini di atas:**

```bash
DOMAIN="server.rangkaian.net"
EMAIL="your-email@example.com"
CF_API_KEY="your_cloudflare_global_api_key"
```

> Pastikan `CF_API_KEY` adalah **Global API Key** dari Cloudflare.

2. **Simpan sebagai file:**

```bash
nano setup_certbot_cloudflare.sh
```

3. **Jalankan skrip:**

```bash
chmod +x setup_certbot_cloudflare.sh
sudo ./setup_certbot_cloudflare.sh
```

