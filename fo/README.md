Ah, sip! Kalau begitu kamu mengusung konsep **FTTH dengan last-mile LAN**, dan itu adalah pendekatan **paling realistis, efisien, dan banyak dipakai** di RT/RW Net maupun ISP kecil. Artinya:

* **Fiber optik tetap sampai ke rumah pelanggan (dropcore)**
* Di rumah, dipasang **ONT/ONU bridge**
* Output-nya berupa **RJ45 LAN** → langsung masuk ke **WiFi router / PC pelanggan**

---

## 🏗️ Skema Final FTTH + Last-Mile LAN

```
          [Internet / ISP]
                |
          [PC Router (RouterOS/pfSense)]
             |         |
         [SFP Port]   [LAN Port (mgmt)]
             |
      [SFP Module + FO Core]
             |
     [Passive Splitter 1:8/1:16]
         /     |       \
     [ONT1]  [ONT2]   [ONT3]
       |        |        |
   [WiFi1]   [WiFi2]   [WiFi3]
    (LAN)     (LAN)     (LAN)
```

---

## ✅ Komponen Perlu Kamu Siapkan

| Fungsi          | Rekomendasi Komponen                                             |
| --------------- | ---------------------------------------------------------------- |
| **PC Router**   | PC dengan NIC SFP (Intel X520, Chelsio) + RouterOS x86 / pfSense |
| **SFP Module**  | SFP 1.25G 1310nm SM (misalnya Finisar, TP-Link)                  |
| **Fiber Core**  | FO G.657A1 1 core atau 2 core, mode single-mode                  |
| **Splitter**    | PLC Splitter SC/APC 1:8 atau 1:16                                |
| **ONT**         | Huawei HG8310M, ZTE F601 (mode bridge)                           |
| **WiFi Router** | TP-Link TL-WR840N, Tenda AC6, dll (di sisi pelanggan)            |
| **ODP/DB FO**   | Untuk distribusi dropcore ke pelanggan                           |

---

## 🛠️ Hal yang Perlu Diperhatikan

* **Konfigurasikan ONT dalam mode bridge** (no NAT, no DHCP, hanya forwarding).
* Di **PC router** kamu, buatkan DHCP server, NAT, queue, atau PPPoE server.
* Gunakan warna label dan manajemen kabel yang rapi agar pemeliharaan mudah.
* Dokumentasikan IP/MAC tiap pelanggan.

---

## 📦 Bonus: Rekomendasi Tambahan

* Gunakan **mikrotik CAPsMAN** kalau ingin kontrol WiFi pelanggan terpusat.
* Pasang **radius server** jika memakai PPPoE.
* Gunakan **DDNS + domain** agar identitas RT/RW Net-mu bisa dilihat publik.

---

Kalau kamu mau, aku bisa bantu buatkan:

* Template spreadsheet untuk manajemen pelanggan (IP, MAC, bandwidth)
* Script konfigurasi RouterOS dasar untuk setup DHCP, NAT, dan queue

Mau lanjut ke situ?
