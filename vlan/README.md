#VLAN-100

```sh
awangga@awangga-MacBookPro:~$ ssh -o HostKeyAlgorithms=+ssh-rsa admin@10.0.0.1
admin@10.0.0.1's password: 
Wireless>                                                                                                                    
  add              Configure system params                                                                                   
  arping           Network arping                                                                                            
  clean            Clean logs on flash                                                                                       
  debug            Debugging functions (see also 'undebug')                                                                  
  del              Configure system params                                                                                   
  end              End current mode and change to enable mode.                                                               
  exec             Execute jobs                                                                                              
  exit             Exit current mode and down to previous mode                                                               
  factory          Reset config                                                                                              
  free             Display amount of free and used memory in this system                                                     
  no               Negate a command or set its defaults                                                                      
  password         Change password for admin                                                                                 
  ping             Network ping                                                                                              
  ps               Report a snapshot of the current processes                                                                
  reboot           Reboot system                                                                                             
  reconnect        Disconnect from AC and connect again                                                                      
  scp              Special Containment Procedures                                                                            
  set              Configure system params                                                                                   
  show             Show running system information                                                                           
  speedtest        Speed test                                                                                                
  ssh              Start SSH connection                                                                                      
  tcpdump          Dumpping packet infomation                                                                                
  telnet           Start telnet connection                                                                                   
  terminal         Set terminal line parameters                                                                              
  timeout          Configure terminal timeout                                                                                
  top              Display Linux tasks                                                                                       
  traceroute       Network trace route                                                                                       
  troubleshooting  Tar all logs of /data to /tmp                                                                             
  upgrade          Upgrade system software                                                                                   
Wireless> exit                                                                                                               
Connection to 10.0.0.1 closed.                                                                                               
awangga@awangga-MacBookPro:~$ nmap -sV 10.0.0.1
Starting Nmap 7.80 ( https://nmap.org ) at 2025-09-10 07:53 WIB
Nmap scan report for _gateway (10.0.0.1)
Host is up (0.017s latency).
Not shown: 995 closed ports
PORT     STATE SERVICE    VERSION
22/tcp   open  ssh        Dropbear sshd (protocol 2.0)
23/tcp   open  telnet     BusyBox telnetd
53/tcp   open  domain?
2601/tcp open  tcpwrapped
9000/tcp open  http       lighttpd 1.4.54
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port53-TCP:V=7.80%I=7%D=9/10%Time=68C0CC28%P=x86_64-pc-linux-gnu%r(DNSV
SF:ersionBindReqTCP,20,"\0\x1e\0\x06\x81\x84\0\x01\0\0\0\0\0\0\x07version\
SF:x04bind\0\0\x10\0\x03");
Service Info: Host: OpenWrt; OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 143.49 seconds
awangga@awangga-MacBookPro:~$ 
```

Nah pas banget mas Rolly 👍

Kalau laptop kamu dijadikan **gateway + DHCP server** untuk AP di VLAN 100, maka AP akan “lari” ke laptop kamu buat CAPWAP discovery. Jadi cara capture dengan `tcpdump` memang seperti yang kamu tulis, tinggal sedikit tambahan supaya lebih lengkap:

---

## 🔹 1. Interface VLAN 100

Kalau interface kamu sudah bikin VLAN:

```bash
sudo ip link add link enp2s0f0 name enp2s0f0.100 type vlan id 100
sudo ip addr add 172.16.1.1/24 dev enp2s0f0.100
sudo ip link set enp2s0f0.100 up
```

dan DHCP server (misalnya `isc-dhcp-server`) sudah listen di `enp2s0f0.100`, berarti AP akan dapat IP via DHCP dari laptop kamu.

---

## 🔹 2. Perintah tcpdump

Ya, perintah kamu sudah pas:

```bash
sudo tcpdump -i enp2s0f0.100 udp port 5246 -w capwap.pcap
```

Artinya:

* **-i enp2s0f0.100** → capture khusus interface VLAN 100
* **udp port 5246** → filter hanya CAPWAP control traffic
* **-w capwap.pcap** → simpan ke file untuk analisis Wireshark

Kalau mau lihat live di terminal (hexdump + ringkas):

```bash
sudo tcpdump -i enp2s0f0.100 -nnvv udp port 5246
```

Kalau sekalian capture juga CAPWAP data channel:

```bash
sudo tcpdump -i enp2s0f0.100 udp port 5246 or udp port 5247 -w capwap.pcap
```

---

## 🔹 3. Analisis di Wireshark

Nanti buka `capwap.pcap`:

* Filter: `capwap`
* Cari **Discovery Request / Response**
* Cari **Join Request / Response**
* Lihat **WLAN Config TLV** → biasanya ada SSID, encryption, VLAN.

---

📌 **Kesimpulan:**
✅ Perintah kamu sudah benar untuk kondisi laptop jadi DHCP server VLAN 100.
✅ Kalau mau lebih lengkap, tambahin `or udp port 5247` biar dapat control + data.
✅ Setelah itu analisis file `capwap.pcap` di Wireshark → itulah kunci untuk bikin fake CAPWAP di Go.

---

👉 Mau saya kasih contoh **Wireshark field yang biasanya berisi SSID & security** supaya kamu tahu harus cari di TLV mana saat analisis `capwap.pcap`?



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
