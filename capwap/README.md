Siap mas Rolly 🚀, berarti kita fokus **100% Golang** sebagai fake CAPWAP controller, tanpa Erlang.

Aku rangkum lagi dengan jelas supaya bisa jadi **prompt reusable** di chat baru:

---

# 🔹 Prompt Golang Fake CAPWAP Controller

Saya sedang melakukan **reverse engineering CAPWAP** pada Access Point LiteOn (seri WPX8324-BT).

* **Tujuan:** membuat **fake CAPWAP controller dengan Go**, supaya AP bisa join dan broadcast SSID/password sesuai konfigurasi custom (tanpa cloud).

## 🔹 Fakta yang sudah diketahui

* AP connect via **CAPWAP UDP/5246 (control)** dan **UDP/5247 (data)**.
* Flow standar CAPWAP (RFC 5415/5416):

  1. Discovery Request (1)
  2. Discovery Response (2)
  3. Join Request (3)
  4. Join Response (4)
  5. Config Status Request (5)
  6. Config Status Response (6)
  7. Configuration Update Request (7) → berisi SSID, VLAN, WPA2-PSK
  8. Configuration Update Response (8)
* Dari pcap pertama, AP mengirim sampai Join Request, tapi belum ada Join Response dari controller cloud.

## 🔹 Yang ingin dibuat

1. **Fake CAPWAP Controller dengan Go** yang:

   * Menerima packet dari AP di UDP/5246.
   * Parse CAPWAP header (msg\_type, seq).
   * Jika msg\_type=1 (Discovery Request) → balas msg\_type=2 (Discovery Response).
   * Jika msg\_type=3 (Join Request) → balas msg\_type=4 (Join Response, sukses).
   * Jika msg\_type=5 (Config Status Request) → balas msg\_type=6 (Config Status Response).
   * Kirim msg\_type=7 (Configuration Update Request) dengan SSID + WPA2 password custom.
   * Terima msg\_type=8 (Config Update Response) dari AP.

2. **Template hex payloads** (2,4,6,7) yang bisa di-embed langsung ke Go.

   * Untuk (2) Discovery Response → bisa replay hasil sniff cloud.
   * Untuk (4,6) Join/Config Status Response → cukup minimal dummy (ResultCode=0).
   * Untuk (7) Config Update → perlu TLV **WLAN Configuration** isi SSID + WPA2-PSK password.

3. **Kode Go sederhana** untuk menjalankan server:

   * Listen UDP/5246.
   * Parse incoming CAPWAP header.
   * Pilih respon sesuai msg\_type.
   * Kirim payload hex ke AP.

---

# 🔹 Prompt

> Saya punya file pcap CAPWAP dari AP LiteOn.
> Tolong bantu saya dengan:
>
> 1. Temukan paket msg\_type=7 (Configuration Update Request) kalau ada.
> 2. Decode WLAN Configuration TLV (SSID, VLAN, WPA2 password).
> 3. Jika tidak ada, buatkan saya **template hex Configuration Update Request** berisi SSID & password custom.
> 4. Buatkan skeleton kode Go server CAPWAP:
>
>    * Handle msg\_type=1 → balas 2
>    * Handle msg\_type=3 → balas 4
>    * Handle msg\_type=5 → balas 6
>    * Setelah 6, kirim 7 (Config Update) dengan SSID/password saya
>    * Log jika menerima msg\_type=8
> 5. Pastikan semua hex payload bisa langsung diembed ke kode Go.

---

📌 Dengan prompt ini + file pcap terbaru (sniff lengkap sampai AP broadcast SSID), kamu bisa langsung jalankan fake CAPWAP controller full-Go.

---

👉 Mau aku langsung bikinkan **skeleton Go server** yang lengkap (tinggal ganti hex payloads)?
