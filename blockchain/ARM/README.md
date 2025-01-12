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



## Bug Fix Blake

https://github.com/glukolog/cpuminer-opt

```sh
crypto/blake2s.c: In function ‘blake2s’:
crypto/blake2s.c:326:9: error: size of array element is not a multiple of its alignment
  326 |         blake2s_state S[1];
      |         ^~~~~~~~~~~~~
```

```c
#include <stdint.h>
#include <stddef.h> // Untuk NULL

int blake2s(uint8_t *out, const void *in, const void *key, uint8_t outlen, uint64_t inlen, uint8_t keylen) {
    blake2s_state S; // Ganti array [1] dengan struktur tunggal untuk menghindari masalah alignment.

    /* Validasi parameter */
    if (in == NULL || out == NULL) {
        return -1; // Parameter tidak valid
    }

    if (key == NULL && keylen > 0) {
        return -1; // Jika keylen > 0, key tidak boleh NULL
    }

    if (outlen == 0 || outlen > BLAKE2S_OUTBYTES) {
        return -1; // Panjang output tidak valid
    }

    if (keylen > BLAKE2S_KEYBYTES) {
        return -1; // Panjang kunci tidak valid
    }

    /* Inisialisasi state berdasarkan keberadaan kunci */
    if (keylen > 0) {
        if (blake2s_init_key(&S, outlen, key, keylen) < 0) {
            return -1;
        }
    } else {
        if (blake2s_init(&S, outlen) < 0) {
            return -1;
        }
    }

    /* Proses input */
    if (blake2s_update(&S, (const uint8_t *)in, inlen) < 0) {
        return -1; // Gagal memperbarui hash
    }

    /* Finalisasi hash */
    if (blake2s_final(&S, out, outlen) < 0) {
        return -1; // Gagal menyelesaikan hash
    }

    return 0; // Berhasil
}
```
