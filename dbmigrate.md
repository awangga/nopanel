# Mysql Migration
On source :

```sh
mysqldump -u root -p --opt carcentos > ra.sql
scp ra.sql stimlog@192.168.1.219:~/
```

On destination :

```sh
mysql -u root -p ra < ra.sql
```