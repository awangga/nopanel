# nopanel
DevOps Tools and Documentation

## GIT-SCM
Please make sure your server or desktop has SSH key. To check it please do this command

```sh
cat ~/.ssh/id_rsa.pub
```

if there is no key appears, plese generate the key also set global config of git and please add the public key to your github profile.

```sh
ssh-keygen -t rsa -b 4096 -C "rolly@awang.ga"
git config --global user.email "rolly@awang.ga"
git config --global user.name "Rolly Maulana Awangga"
cat ~/.ssh/id_rsa.pub
```

[Detail Tutorial using git](git.md)

## Connect Source Code to Git
Please create git repo first and copy ssh uri, for example :

git@github.com:awangga/crot.git

use it in replace with : git remote add origin 
Go to your website folder for example in : /var/www/html/siap

```sh
cd /var/www/html/siap
git init
git commit -m "first commit"
git remote add origin git@github.com:awangga/crot.git
git pull origin master --allow-unrelated-histories
git push origin master
```

## MariaDB Database migration
If database name is dbname then, On Source Server :

```sh
mysqldump -u root -p --opt dbname > dbname.sql
scp dbname.sql user@192.168.1.219:~/
```

then go to target server:

```sh
ssh user@192.168.1.219
mysql -u root -p dbname < dbname.sql
```

## SSH Without Password

Using git bash create yout key, you dont have to do this if you already have a key
```sh
ssh-keygen -t rsa -b 4096 -C "rolly@awang.ga"
```

send key to the server
```sh
cat ~/.ssh/id_rsa.pub | ssh usernya@hostnya.com 'cat >> .ssh/authorized_keys'
```

ssh into server and change permission
```sh
chmod 700 .ssh; chmod 640 .ssh/authorized_keys
```

Check Disk Usage
```sh
sudo du -hc --max-depth=1 /
```