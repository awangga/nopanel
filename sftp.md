# SFTP
## Open terminal

```sh
root@api [/var/www/html]# groupadd sftponly
root@api [/var/www/html]# useradd gameapi
root@api [/var/www/html]# usermod gameapi -g sftponly
usermod: user 'sftponly' does not exist
root@api [/var/www/html]# usermod -g sftponly gameapi
root@api [/var/www/html]# usermod -s /usr/lib/openssh/sftp-server gameapi
root@api [/var/www/html]# usermod -d /var/www/html/shark/ gameapi
root@api [/var/www/html]# id gameapi
uid=500(gameapi) gid=500(sftponly) groups=500(sftponly)
root@api [/var/www/html]# vi /etc/ssh/sshd_config 
```

```sh
# override default of no subsystems
Subsystem	sftp	/usr/libexec/openssh/sftp-server

# Example of overriding settings on a per-user basis
#Match User anoncvs
#	X11Forwarding no
#	AllowTcpForwarding no
#	ForceCommand cvs server

Match User gameapi
	ChrootDirectory /var/www/html/shark/
	ForceCommand /usr/libexec/openssh/sftp-server
	AllowTcpForwarding no
```

```sh
root@api [/var/www/html]# passwd gameapi
Changing password for user gameapi.
New password: 
Retype new password:
root@api # echo '/usr/lib/openssh/sftp-server' >> /etc/shells
root@api [/var/www/html]# sudo service sshd reload
```