# ARM Compile
Debian based
```sh
sudo apt update
sudo apt install build-essential automake autoconf libcurl4-openssl-dev libssl-dev zlib1g-dev libjansson-dev libgmp-dev
```

freebsd based
```sh
pkg update
pkg upgrade
pkg install git clang make automake autoconf curl openssl zlib libjansson
```

clone dan compile

```sh
git clone --depth 1 https://github.com/awangga/cpuminer-opt.git
cd cpuminer-opt
./build.sh
./cpuminer
```


## ARM32

YesScript using cpuminer-multi

```sh
git clone https://github.com/tpruvot/cpuminer-multi.git
cd cpuminer-multi


$ cat /proc/cpuinfo
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm
```
Run this command
```sh
lscpu
make clean
```

Configure and make

```sh
export CFLAGS="-O3 -march=native+neon"
export LDFLAGS="-lcurl -lssl -lcrypto -lz -ljansson"
autoreconf -fiv
./autogen.sh
./configure
make V=1
make clean
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
