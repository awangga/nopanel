# ARM Compile

## ARM32

YesScript using cpuminer-multi

```sh
$ cat /proc/cpuinfo
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm
```
Run this command
```sh
lscpu
sudo apt update
sudo apt install libcurl4-openssl-dev
sudo apt install libssl-dev
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



./configure CFLAGS="-O3 -march=native" LDFLAGS="-lcurl -lssl -lcrypto -lz"
make
```