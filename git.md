# Penggunaan git

## Get SSH Key 
to get ssh key in your computer, and put in your github or gitlab ssh key setting.

```sh
cat ~/.ssh/id_rsa.pub
```
if there is no key appears, plese generate the key also set global config of git in next section and please add the public key to your github profile.

## Generate RSA Key
Just One time for first instalation of git scm, 
```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## Set config global
Just One time for first instalation of git scm, 

```sh
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

## Enabling SSH connections over HTTPS

Just in case if your wifi or lan blocking port 22

```sh
$ nano ~/.ssh/config
```

```sh
Host github.com
  Hostname ssh.github.com
  Port 443
  User git

Host gitlab.com
  Hostname altssh.gitlab.com
  User git
  Port 443
```

## Forking repository and keep update from source repo
Please click fork from web interface, after that clone your repo in your desktop. Select SSH in clone tab.

```sh
git clone git@github.com:youruserrepo/geojson.git
```

git bash into your repo folder, just one time add upstream from source of fork repo. Use HTTPS in clone tab from source repo.

```sh
git remote add upstream https://github.com/bukped/geojson.git
```

before pull request and working in your repo, always do

```sh
git fetch upstream
git checkout main
git merge upstream/main
```

After that you may pull request.
