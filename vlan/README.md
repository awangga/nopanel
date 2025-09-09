## DHCP Server

Wah ini seru 😎. Jadi skenarionya:

* Laptop Lubuntu kamu punya **Wi-Fi (wlp3s0)** yang sudah konek internet.
* Laptop juga punya **Ethernet VLAN100 (enp2s0f0.100)** ke AP.
* Kamu mau bikin laptop bertindak sebagai **DHCP server + NAT router**, supaya AP (dan client di VLAN100) bisa dapat internet.

Bisa banget 👇

---

## 🔹 1. Install Paket Pendukung

```bash
sudo apt update
sudo apt install isc-dhcp-server iptables-persistent
```

> Bisa juga pakai `dnsmasq` kalau mau lebih simpel.

---

## 🔹 2. Set DHCP Server di VLAN100

Edit file DHCP:

```bash
sudo nano /etc/dhcp/dhcpd.conf
```

Contoh konfigurasi untuk VLAN100 (subnet 172.16.1.x):

```conf
subnet 172.16.1.0 netmask 255.255.255.0 {
  range 172.16.1.100 172.16.1.200;
  option routers 172.16.1.1;
  option domain-name-servers 8.8.8.8, 1.1.1.1;
}
```

* Router (gateway) = IP laptop di VLAN100 (`172.16.1.1`).
* DHCP akan kasih IP ke AP/client di range `172.16.1.100-200`.

Atur interface DHCP supaya hanya jalan di `enp2s0f0.100`:

```bash
sudo nano /etc/default/isc-dhcp-server
```

Isi:

```conf
INTERFACESv4="enp2s0f0.100"
```

---

## 🔹 3. Set IP Laptop di VLAN100

```bash
sudo ip addr add 172.16.1.1/24 dev enp2s0f0.100
sudo ip link set enp2s0f0.100 up
```

---

## 🔹 4. Aktifkan IP Forwarding

```bash
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
```

Biar permanen, edit:

```bash
sudo nano /etc/sysctl.conf
```

Uncomment:

```
net.ipv4.ip_forward=1
```

---

## 🔹 5. NAT (Share Internet dari Wi-Fi ke VLAN100)

Asumsikan internet masuk via `wlp3s0` (Wi-Fi):

```bash
sudo iptables -t nat -A POSTROUTING -o wlp3s0 -j MASQUERADE
sudo iptables -A FORWARD -i wlp3s0 -o enp2s0f0.100 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i enp2s0f0.100 -o wlp3s0 -j ACCEPT
```

Simpan rules:

```bash
sudo netfilter-persistent save
```

---

## 🔹 6. Jalankan DHCP

```bash
sudo systemctl restart isc-dhcp-server
sudo systemctl status isc-dhcp-server
```

Kalau sukses, AP/client di VLAN100 akan dapat IP otomatis (172.16.1.x) dan bisa browsing internet lewat Wi-Fi laptop.

---

## 🔹 7. Debugging

* Cek log DHCP:

```bash
journalctl -u isc-dhcp-server -f
```

* Cek client dapat IP:

```bash
arp -a
```

---

📌 Ringkasnya:
Laptop = **gateway mini** → Wi-Fi (`wlp3s0`) ambil internet, VLAN100 (`enp2s0f0.100`) jadi DHCP server + NAT ke Wi-Fi.

---

👉 Mau saya bikinkan versi **pakai dnsmasq** (lebih ringan, 1 file config, cocok kalau hanya buat eksperimen AP ini)?
