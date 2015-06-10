# nopanel
Web Hosting Panel for Advance User
###Preparation for installation
1. Install Webmin
   - add repository
   - add signature
   - yum install webmin
2. Install Virtualmin
   - wget http://*wbm*.rpm
   - wget http://*wbt*.rpm
   - rpm -ivh wbm*.rpm
   - rpm -ivh *wbt*.rpm
3. Virtualmin theme activated from webmin user interface
   - login to your webmin interface on webmin menu choose Change Language and Theme>Personal choice ..  
   - klik make changes
   - close browser and open your webmin user interface again
4. Install MySQL
   - yum install mysql-server
   - service mysqld start
   - /usr/bin/mysqladmin -u root password 'new-password'
   - /usr/bin/mysqladmin -u root -h semar.passionit.net password 'new-password'
   - /usr/bin/mysql_secure_installation
   - service mysqld start
   - chkconfig mysqld on
   - input your root password on webmin
5. Taken from [The Web Site People]. Create file /home/chroot/chroot.sh with in the repo give executable permission
6. Set the home directory template in Virtualmin accordingly:
   - Virtualmin -> System Settings -> Virtualmin Configuration -> Defaults for new domains -> Home directory base: /home/chroot/$USER/home
   - Virtualmin -> System Settings -> Virtualmin Configuration -> Defaults for new domains -> Home subdirectory: $DOM
   - Note that both settings are required, even if ${DOM} is the default, as Virtualmin will not correctly interpolate the directory unless a manual template is set.
7. Add a custom command to handle setting up and cleaning up the chroot:
   - Virtualmin -> System Settings -> Virtualmin Configuration ->Actions upon server and user creation -> Command to run before making changes to a server: /home/chroot/chroot.sh
   - Virtualmin -> System Settings -> Virtualmin Configuration ->Actions upon server and user creation -> Command to run after making changes to a server: /home/chroot/chroot.sh
8. Create Group : sftponly
9. Add Virtualmin users to a secondary group that sshd can identify for SFTP-only access:
   - Virtualmin -> System Settings -> Server Templates -> Default Settings -> Administration user -> Add domain owners to secondary group: sftponly
10. Update /etc/ssh/sshd_config to set SFTP-only access for members of this group:
   - Subsystem       sftp    internal-sftp
   - Match Group sftponly
   	 - ChrootDirectory /home/chroot/%u
     - ForceCommand internal-sftp
     - AllowTcpForwarding no   

11. Reload sshd:
``
$ services sshd reload
``

###PHP
```sh
# yum install php php-mysql
# service httpd reload
```


###ssl for https
```sh
# yum install mod_ssl openssl
# openssl genrsa -des3 -out your-domain.com.key 4096
# openssl req -new -key your-domain.com.key -out your-domain.com.csr
# openssl x509 -req -days 700 -in your-domain.com.csr -signkey your-domain.com.key -out your-domain.com.crt
# mkdir -p /etc/httpd/ssl/
# cp your-domain.com.crt /etc/httpd/ssl/
# cp your-domain.com.key /etc/httpd/ssl/
# vi /etc/httpd/conf.d/your-domain.com.conf
# service httpd restart
```

###add EPEL Repositories
```sh
# wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# rpm -ivh epel-release-6-8.noarch.rpm
```

###phpmyadmin
```sh
# yum install phpmyadmin
# vim /etc/httpd/conf.d/phpMyAdmin.conf
# service httpd reload
```

###mod-itk for running vhost as vhost user
```sh
#yum install httpd-itk.x86_64
#nano /etc/sysconfig/httpd
#nano /etc/httpd/conf/httpd.conf
#nano /etc/httpd/conf.d/php.conf
```

License
----

GNU Affero General Public License



[The Web Site People]:http://blog.thewebsitepeople.org/2012/10/virtualmin-sftp-chroot/
[The Geek Stuff]:http://www.thegeekstuff.com/2012/03/chroot-sftp-setup/
[Virtualmin Manual]:http://www.virtualmin.com/documentation/developer/prepost
[Rosehosting]https://www.rosehosting.com/blog/installing-and-securing-phpmyadmin-4-on-centos-6/
[mpm-itk]http://itsol.biz/apache-virtual-hosts-with-different-users-centos-6-2-and-apache-2-2/