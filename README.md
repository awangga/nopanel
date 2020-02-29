# nopanel
Simple Server Set Up without Panel

#SSH Wirhout Password

Using git bash create yout key, you dont have to do this if you already have a key
```sh
ssh-keygen -t rsa -b 4096 -C "rolly@awangga.com
```

send key to the server
```sh
cat ~/.ssh/id_rsa.pub | ssh usernya@hostnya.com 'cat >> .ssh/authorized_keys'
```

ssh into server and change permission
```sh
chmod 700 .ssh; chmod 640 .ssh/authorized_keys
```