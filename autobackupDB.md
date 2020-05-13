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
30 2 * * * /home/stimlog/crondump.sh
```