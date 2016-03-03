# SFTP
## Open terminal

```sh
# groupadd sftponly
# useradd gameapi
# usermod gameapi -g sftponly
usermod: user 'sftponly' does not exist
# usermod -g sftponly gameapi
# usermod -s /bin/false gameapi
# usermod -d /var/www/html/shark/ gameapi
# id gameapi
uid=500(gameapi) gid=500(sftponly) groups=500(sftponly)
# vi /etc/ssh/sshd_config 
```

```sh
# override default of no subsystems
Subsystem	sftp	internal-sftp

# Example of overriding settings on a per-user basis
#Match User anoncvs
#	X11Forwarding no
#	AllowTcpForwarding no
#	ForceCommand cvs server

Match User gameapi
	ChrootDirectory /var/www/html/shark/
	ForceCommand internal-sftp
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