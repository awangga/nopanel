# siti
sistem akademik tanpa henti
## Database
config database ada di dua file :
1. stimlog/modul/simpati/simpati.koneksi.php
2. stimlog/besan.config.php
3. siti/ci-app/simpati/config/database.php hanya pada blok['stimlog']

## Upgrade Codeigniter module
Edit pada baris 257 file :
ci-system/core/Common.php

```php
//		return $_config[0] =& $config;
//baris 257 ubah menjadi 2 baris
$_config[0] =& $config;
return $_config[0];
```