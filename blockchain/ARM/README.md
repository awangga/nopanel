# ARM Compile

```sh
sudo apt update
sudo apt install build-essential automake autoconf libcurl4-openssl-dev libssl-dev zlib1g-dev
```

## ARM32

YesScript using cpuminer-multi

```sh
$ cat /proc/cpuinfo
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm
```
Run this command
```sh
lscpu
make clean
```

```sh
git clone https://github.com/tpruvot/cpuminer-multi.git
cd cpuminer-multi


./autogen.sh
./configure CFLAGS="-O3"
make


CFLAGS="-march=native" ./autogen.sh
./configure CFLAGS="-O3"
make

CFLAGS="-march=armv8-a+crypto+neon -O3" ./configure



./configure CFLAGS="-O3 -march=native+neon" LDFLAGS="-lcurl -lssl -lcrypto -lz"
make
```

---

### **1. Jalankan `./configure` dengan CFLAGS dan LDFLAGS**
Gunakan perintah berikut:
```bash
./configure CFLAGS="-O3 -march=native+neon" LDFLAGS="-lcurl -lssl -lcrypto -lz"
```

- **`CFLAGS="-O3 -march=native+neon"`**:
  - `-O3`: Optimasi tingkat tinggi untuk kinerja maksimum.
  - `-march=native+neon`: Menggunakan semua fitur yang didukung oleh CPU Anda, termasuk NEON.

- **`LDFLAGS="-lcurl -lssl -lcrypto -lz"`**:
  - `-lcurl`: Menghubungkan pustaka **libcurl**.
  - `-lssl`: Menghubungkan pustaka **OpenSSL**.
  - `-lcrypto`: Menghubungkan pustaka kriptografi.
  - `-lz`: Menghubungkan pustaka **zlib** untuk kompresi.

---
