## Dokumentasi Docker

1. Buka Gitlab, dan buat repo baru , klik button new project
![New Project](image-1.png)
2. Kemudian pilih create blank project
![Blank Project](image-2.png)
3. Isi nama repository dan group untuk project URL, kemudian klik create project
![Project URL](image-3.png)
4. Maka tampilan akan seperti ini 
![Tampilan repository](image-4.png)
5. Kemudian clone repository (optional bisa pilih ssh atau http , diusahakan ssh)
![Code repository](image-5.png)
6. Clone menggunakan git bash anda
![Git clone](image-6.png)
7. Buka project yang sudah diclone melalui visual studio code, untuk cara cepatnya seperti di gambar berikut
![git bash](image-7.png)
8. Kemudian isi project anda dengan skeleton dari github.com/gocroot/gocroot
![gocroot](image-8.png)
9. Lalu download ZIPnya, kemudian ekstrak file pada folder project seperti pada gambar berikut ini
![ekstrak folder](image-9.png)
10. Kemudian, pindahkan isi folder ke dalam folder ux (project awal)
11. Selanjutnya, lakukan go mod tidy
![go mod tidy](image-10.png)
12. Jika program tidak berjalan atau too long respond, hapus file go mod dan go.sum kemudian lakukan langkah berikut
![go init](image-11.png)
13. Jalankan Nekoray
![nekoray](image-12.png)
14. Jika nekoray anda disconnect lakukan nslookup pada command line
![Nslookup](image-13.png)
15. Ubah DNS pada jaringan internet anda, Untuk windows masuk ke WIFI settings > Edit DNS
![Ubah DNS](image-14.png)
16. Ubah ke Manual dan pilih IPv4
![IPV4](image-15.png)
17. Masukan dns address hasil nslookup
![paste](image-17.png)
15. Jalankan program dengan perintah go run .
![after run](image-18.png)
17. Buka browser anda kemudian akses local yang ada pada tampilan fiber vs code
18. Jika Berhasil tampilan browser seperti ini
![tampilan berhasil](image-19.png)
