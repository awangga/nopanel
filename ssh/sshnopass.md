ssh-keygen -t rsa -b 4096 -C "rolly@awangga.com"



mkdir .ssh
>.ssh/authorized_keys
chmod 700 .ssh; chmod 640 .ssh/authorized_keys


cat ~/.ssh/id_rsa.pub | ssh usernya@hostnya.com 'cat >> .ssh/authorized_keys'
