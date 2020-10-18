# Mysql Auto Backup per Week
Langkah :
1. pada home folder buat folder sqldump, kemudian disini dicontohkan path menggunakan home folder user stimlog
2. buat script bernama crondump.sh yang berisi beberapa database yang mau di otomasi backup dengan mengubah variabel dbname :

```sh
dumpfolder='/home/stimlog/sqldump'
userdb='root'
passdb='P@sswordsDBnya'
today=$(date +"%Y_%m_%d")
lastweek=$(date +%Y_%m_%d -d "1 week ago")

# Database 1
dbname='moodleb'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
# Database 2
dbname='db_ypbpi'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
# Database 3
dbname='form_pmb_stimlog'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
# Database 4
dbname='pmbweb_2019'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
# Database 5
dbname='ra'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
# Database 6
dbname='rere'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
```

3. Kemudian ubah mode file crondump.sh ke eksekusi dan masukkan perintah crondump.sh ke crontab :

```sh
chmod a+x crondump.sh
crontab -e
```

isi dari file crontab tersebut dengan:
```sh
30 2 * * * /home/stimlog/crondump.sh
```

## Postgresql Auto Backup per Week
Langkah :
1. pada home folder buat folder sqldump, kemudian disini dicontohkan path menggunakan home folder user root
2. buat script bernama crondump.sh yang berisi beberapa database yang mau di otomasi backup dengan mengubah variabel dbname :

```sh

# Database 1
dumpfolder='/root/sqldump'
userdb='doadmin'
passdb='j0p1j783pb7kiq71'
dbhost='private-db-postgresql-sgp1-n1-do-user-8118846-0.b.db.ondigitalocean.com'
dbport='25060'
dbname='affiliatedb'

today=$(date +"%Y_%m_%d")
lastweek=$(date +%Y_%m_%d -d "1 week ago")

PGPASSWORD=$passdb pg_dump -U $userdb -h $dbhost -p $dbport -w -c -d $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
# Database 2
dbname='db_ypbpi'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
# Database 3
dbname='form_pmb_stimlog'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
# Database 4
dbname='pmbweb_2019'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
# Database 5
dbname='ra'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
# Database 6
dbname='rere'
mysqldump -u $userdb -p$passdb --opt $dbname > $dumpfolder/$dbname.$today.sql
rm $dumpfolder/$dbname.$lastweek.sql
```

buat file .pgpass
```sh
nano ~/.pgpass
#hostname:port:database:username:password
*:5432:*:username:password
chmod 0600 ~/.pgpass
```

3. Kemudian ubah mode file crondump.sh ke eksekusi dan masukkan perintah crondump.sh ke crontab :

```sh
chmod a+x crondump.sh
crontab -e
```

isi dari file crontab tersebut dengan:
```sh
30 2 * * * /home/stimlog/crondump.sh
```

Restore db_ypbpi
```sh
psql -U postgres -W -f ~/Example_Dumps/ex_back2_db.sql
```