# Penggunaan git

## Get SSH Key 
to get ssh key in your computer, and put in your github or gitlab ssh key setting.

```sh
cat ~/.ssh/id_rsa.pub
```
if there is not exist you must generate ssh key in next section

## Generate RSA Key
Just Once for first instalation of git scm, 
```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## Set config global

```sh
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```
