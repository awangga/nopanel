# Penggunaan git

## Generate RSA Key
Just Once for first instalation of git scm
```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## Set config global

```sh
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

## Get SSH Key 
to get ssh key in your computer

```sh
cat .ssh/id_rsa.pub
```