# nopanel
DevOps Tools and Documentation. If your desktop using windows, download and install [git-scm](https://git-scm.com/downloads). Use terminal or git bash for the next section.

## SSH Key
Please make sure your server or desktop has SSH key. To check it please do this command :

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

## Using Google Colab with Drive and Git Repository

Mounting drive and generate ssh

```sh
import os
from google.colab import drive
drive.mount('/content/drive')
folder = '/content/drive/My Drive/SK2/fix/siabre' 

savedir=folder
os.chdir(savedir)  #change dir
!pwd
```
generate ssh key, add github.com host, and backup key to current folder for next future use

```sh
!ssh-keygen -t rsa -b 4096 -C "rolly@awang.ga"
!git config --global user.name "Rolly Maulana Awangga"
!git config --global user.email rolly@awang.ga
!ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
!cat ~/.ssh/id_rsa.pub
!cp -R /root/.ssh/ ./ssh/
```

for next use just

```sh
!cp -R ./ssh/ /root/.ssh/
```

clone and change dir

```sh
!git clone url
os.chdir('/content/drive/My Drive/SK2/fix/siabre')
```

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
git pull origin main --allow-unrelated-histories
git push origin main
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

## Cloud Setup

Setup timezone
```sh
sudo dpkg-reconfigure tzdata
date
```
Go Installation
```sh
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go
```
Install Google Drive Connection and tools
```sh
sudo apt install unzip tmux
sudo apt install python3-pip
sudo pip install gdown
```

Update and Maintenance
```sh
gdown uid --folder
tmux
tmux ls
tmux attach #
```

Navigation :
Ctrl+B in same time
1. Page Up : to scrol up