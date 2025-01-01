# Remote X11
Alokasi swap

```sh
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

Ya, **X11 Forwarding dari remote Windows ke GCE** **bisa dilakukan**, meskipun memerlukan beberapa konfigurasi pada **server GCE** dan **klien Windows**. Berikut adalah langkah-langkah untuk mengaturnya:

---

## **1. Konfigurasi pada GCE (Server Linux)**

### a) **Pastikan SSH Server diinstal**
SSH server sudah tersedia secara default pada instance GCE berbasis Linux, tetapi pastikan bahwa paket-paket berikut terinstal:
```bash
sudo apt update
sudo apt install openssh-server xauth xorg
```

### b) **Edit Konfigurasi SSH untuk Mengaktifkan X11 Forwarding**
Edit file konfigurasi SSH server:
```bash
sudo nano /etc/ssh/sshd_config
```
Cari dan pastikan baris berikut tidak dikomentari (hilangkan tanda `#` jika ada):
```plaintext
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes
```

Simpan file (Ctrl+O, Enter, Ctrl+X) lalu restart layanan SSH:
```bash
sudo systemctl restart ssh
```

---

### c) **Pastikan Aplikasi Berbasis X11 Dapat Berjalan**
Jika Anda ingin menjalankan aplikasi berbasis Qt atau X11, pastikan bahwa pustaka-pustaka berikut sudah diinstal di server:
```bash
sudo apt install qt5-default
```

**Contoh pengujian aplikasi X11:**
Jalankan aplikasi seperti `xeyes` (jika diinstal) untuk menguji koneksi:
```bash
sudo apt install x11-apps
xeyes
```

---

## **2. Konfigurasi pada Windows (Klien)**
Untuk melakukan X11 Forwarding dari Windows, Anda memerlukan **X Server** pada mesin Windows. Berikut adalah langkah-langkahnya:

### a) **Unduh dan Instal X Server untuk Windows**
Gunakan salah satu X Server berikut:
1. **VcXsrv (Disarankan)**: [Download di sini](https://sourceforge.net/projects/vcxsrv/)
2. **Xming**: Alternatif yang juga ringan.

---

### b) **Konfigurasi X Server (VcXsrv)**
1. Jalankan **VcXsrv** menggunakan shortcut **"XLaunch"**.
2. Pilih konfigurasi berikut:
   - **Multiple Windows** (pilih opsi ini agar aplikasi X11 muncul di jendela terpisah).
   - Aktifkan **"Disable access control"** agar koneksi dari GCE diterima.
3. Klik "Finish" untuk memulai X Server.

---

### c) **Instal SSH Client di Windows**
Gunakan **PuTTY** atau **OpenSSH** bawaan Windows 10/11:
- **PuTTY**: [Download di sini](https://www.putty.org)
- **OpenSSH** (sudah tersedia di Windows):
  - Pastikan OpenSSH tersedia dengan perintah:
    ```powershell
    ssh -V
    ```
  - Jika belum tersedia, tambahkan melalui **Settings > Apps > Optional Features > Add a Feature**.

---

### d) **Jalankan SSH dengan X11 Forwarding**
1. **PuTTY**:
   - Masukkan alamat IP server di bagian **Host Name (or IP address)**.
   - Pergi ke bagian **Connection > SSH > X11** dan centang **Enable X11 forwarding**.
   - Klik **Open** untuk terhubung.
2. **OpenSSH** (Command Prompt atau PowerShell):
   Gunakan perintah berikut:
   ```bash
   ssh -X username@server_ip
   ```
   atau, jika Anda menggunakan port SSH custom (bukan 22):
   ```bash
   ssh -X -p port_number username@server_ip
   ```

---

### e) **Tes Koneksi X11 Forwarding**
1. Setelah terhubung ke GCE, jalankan aplikasi X11 di terminal SSH:
   ```bash
   xeyes
   ```
   atau aplikasi Qt Anda:
   ```bash
   qtcreator
   ```
2. Aplikasi akan muncul di layar Windows melalui X Server.

---

## **3. Troubleshooting**
- **Aplikasi tidak muncul di Windows**:
  - Pastikan VcXsrv atau Xming sedang berjalan di Windows.
  - Pastikan Anda menggunakan opsi `-X` saat melakukan koneksi SSH.
  - Jika masalah tetap ada, coba gunakan `-Y` untuk **trusted X11 forwarding**:
    ```bash
    ssh -Y username@server_ip
    ```

- **Port 22 diblokir di firewall GCE**:
  - Buka port 22 untuk SSH dalam konfigurasi firewall GCE:
    1. Masuk ke **Google Cloud Console > VPC Network > Firewall Rules**.
    2. Tambahkan aturan baru untuk mengizinkan port **22**.

---

## **Alternatif Tanpa GUI (CLI untuk Qt Development)**
Jika GUI tidak mutlak diperlukan, Anda bisa menggunakan alat berbasis CLI untuk pengembangan Qt, seperti:
1. **Qt Creator (CLI Mode)**:
   ```bash
   qtcreator -platform offscreen
   ```
2. Gunakan editor teks berbasis terminal seperti **vim** atau **nano** dengan pustaka Qt.

---

Dengan langkah-langkah di atas, Anda dapat melakukan X11 Forwarding dari **Windows ke GCE** untuk menjalankan aplikasi berbasis Qt melalui koneksi SSH yang ringan!