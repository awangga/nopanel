Oke 👍 saya bikinkan dua hal langsung:

1. **Scaling (supaya UI jadi kecil → muat lebih banyak aplikasi)**
2. **Shortcut Tiling (supaya aplikasi bisa diatur posisi kiri/kanan/atas/bawah)**

---

## 🔹 1. Atur **Scaling / DPI**

### Cara GUI (paling mudah):

1. Buka **LXQt Configuration Center** → **Appearance** → **Font**.
2. Cari bagian **Font DPI** → ganti nilai default (96) ke **80** atau lebih kecil.

   * DPI lebih kecil = huruf & UI mengecil = lebih banyak ruang di layar.
   * Kalau terlalu kecil, coba bertahap (90, 85, dst).

### Cara manual (`~/.Xresources`):

Buat / edit file `~/.Xresources`:

```bash
Xft.dpi: 80
```

Lalu jalankan:

```bash
xrdb -merge ~/.Xresources
```

Supaya permanen, tambahkan ke `~/.xprofile`:

```bash
xrdb -merge ~/.Xresources &
```

---

## 🔹 2. Shortcut Tiling di LXQt

LXQt bisa atur jendela ke kiri/kanan/atas/bawah dengan **Global Keyboard Shortcuts**.

### Langkah:

1. Buka **LXQt Configuration Center** → **Shortcut Keys**.
2. Tambahkan shortcut baru:

   * **Move Window Left Half** → `Win + Left`
   * **Move Window Right Half** → `Win + Right`
   * **Move Window Top Half** → `Win + Up`
   * **Move Window Bottom Half** → `Win + Down`

Jika tidak ada opsi bawaan, bisa pakai `wmctrl` atau `xdotool`:

```bash
sudo apt install wmctrl xdotool
```

Lalu buat perintah untuk resize window, contoh untuk setengah kiri:

```bash
wmctrl -r :ACTIVE: -e 0,0,0,960,1080
```

(`960,1080` = ukuran setengah dari layar FullHD, sesuaikan dengan resolusi monitormu).

Shortcut ini bisa kamu pasang lewat LXQt → **Shortcut Keys** → jalankan perintah di atas.

---

## 🔹 3. Hasilnya

* Dengan **DPI kecil**, tampilan jadi lebih mungil → lebih banyak aplikasi bisa ditampilkan.
* Dengan **tiling shortcut**, kamu bisa cepat menata 2–4 aplikasi di satu layar.
* Rasanya mirip monitor resolusi tinggi, meskipun hardwarenya tetap sama.

---

Mau saya bikinkan **script otomatis** (misalnya `toggle-tiling.sh`) yang langsung resize jendela ke kiri/kanan/atas/bawah biar tinggal dipasang ke shortcut?
