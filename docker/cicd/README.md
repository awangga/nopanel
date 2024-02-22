# Dokumentasi Docker
## Persiapan Repository

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
14. Jika nekoray anda berada di jaringan lokal lakukan nslookup pada command line
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

## Deploy Docker
1. Buat file Dockerfile pada project anda
![dockerfile](image-20.png)
2. Akses Hub.docker.com kemudian cari golang
![hub docker](image-21.png)
3. Pilih tag yang akan dipakai
![pilih tag](image-22.png)
4. Kemudian pilih latest atau versi yang akan digunakan, selanjutnya copy tagnya
![copy tag](image-23.png)
5. Masukan tag ke dockerfile anda
![form](image-24.png)
6. Buat WORKDIR terlebih dahulu
![workdir](image-25.png)
7. buat COPY TAG
![copy](image-26.png)
8. Buat RUN sesuai dengan file main anda
![Alt text](image-27.png)
9. Kemudian cari DEBIAN di hub docker
![debian](image-28.png)
10. ambil tag seperti pada saat hub golang sebelumnya, pilih tag stable-slim
![Alt text](image-29.png)
12. Pastikan file dockerfile anda seperti gambar berikut
![Alt text](image-30.png)
13. Kemudian buat EXPOSE untuk port yang akan digunakan dan CMD diisi oleh nama file hasil build
![dockerfile](image-31.png)
14. PUSH semua file yang ada langsung ke repository anda


## Setting CI/CD
1. Buka gitlab, dan masuk ke menu setting CI/CD
![CI/CD](image-32.png)
2. Pilih Menu Runner
![runner](image-33.png)
3. Clik New Project runner
![create new project](image-34.png)
4. ceklis run untag jobs
![run untag](image-35.png)
5. Ceklis lock to current project
![lock current project](image-36.png)
6. Masuk ke git bash dan server docker
![halaman runner](image-38.png)
7. Register runner
![reg](image-37.png)
8. Kemudian lakukan enter sebanyak 2 kali dan pilih shell
![Alt text](image-39.png)
9. Kembali ke runner page, dan pastikan runner sudah muncul dan seperti pada gambar berikut
![Alt text](image-40.png)
10. Buat Docker compose, ubah container sesuai dengan nama project anda 
![Alt text](image-41.png)
11. Ubah IP sesuai dengan IP kosong
![Alt text](image-43.png)
12. Pada file DOckerfile tambahkan dumb init
![Alt text](image-45.png)

### Gitlab CI
1. Konfigurasikan gitlab ci seperti pada gambar berikut
```yml

#Setting environment variable runner
variables:
  GIT_DEPTH: 1

#Tahapan build
stages:
  - build
  - deploy


#job untuk build
build-docker:
  #Hanya running di branch main
  only:
    - main
  #tahapan build
  stage: build
  #Perintah yang dijalankan untuk build
  script:
    - docker build -t $CI_REGISTRY_IMAGE:prod-latest -f Dockerfile .
    - docker login -u $CI_DEPLOY_USER -p $CI_DEPLOY_PASSWORD $CI_REGISTRY
    - docker push $CI_REGISTRY_IMAGE:prod-latest
  #konfigurasi ketika gagal
  retry:
    #maksimum retry
    max: 2
    #kondisi ketika retry
    when:
      - runner_system_failure
      - stuck_or_timeout_failure

#job untuk deploy
deploy:
  #tahapan
  stage: deploy
  #hanya menjalankan branch main
  only:
    - main
    #Perintah yang dijalankan untuk deploy
  script:
    - docker login -u $CI_DEPLOY_USER -p $CI_DEPLOY_PASSWORD $CI_REGISTRY
    - docker pull $CI_REGISTRY_IMAGE:prod-latest
    - docker-compose -f docker-compose.yml up -d
    - docker image prune -f
```

## Setting Deploy key
1. Tambahkan deploy token pada menu Repository > deploy tokens
![Alt text](image-44.png)

- Setelah semuanya sudah disetting push semua file ke repository, dan akses IP yang tadi sudah disimpan pada docker compose

