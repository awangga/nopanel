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
   - Virtualmin -> System Settings -> Virtualmin Configuration -> Defaults for new domains -> Home directory base: /home/chroot/${DOM}/home
   - Virtualmin -> System Settings -> Virtualmin Configuration -> Defaults for new domains -> Home subdirectory: ${DOM}
   - Note that both settings are required, even if ${DOM} is the default, as Virtualmin will not correctly interpolate the directory unless a manual template is set.
7. Add a custom command to handle setting up and cleaning up the chroot:
   - Virtualmin -> System Settings -> Virtualmin Configuration ->Actions upon server and user creation -> Command to run before making changes to a server: /home/chroot/chroot.sh
   - Virtualmin -> System Settings -> Virtualmin Configuration ->Actions upon server and user creation -> Command to run after making changes to a server: /home/chroot/chroot.sh
8. Create Group : sftponly
9. Add Virtualmin users to a secondary group that sshd can identify for SFTP-only access:
   - Virtualmin -> System Settings -> Server Templates -> Default Settings -> Administration user -> Add domain owners to secondary group: sftponly
10. Update /etc/ssh/sshd_config to set SFTP-only access for members of this group:

 Subsystem       sftp    internal-sftp
 Match Group sftponly
    ChrootDirectory /home/chroot/%u
    ForceCommand internal-sftp
    AllowTcpForwarding no   

11. Reload sshd:
```sh
    $ systemctl reload sshd.service
```
12. Enjoy

License
----

GNU Affero General Public License



[The Web Site People]:http://blog.thewebsitepeople.org/2012/10/virtualmin-sftp-chroot/
[The Geek Stuff]:http://www.thegeekstuff.com/2012/03/chroot-sftp-setup/
[Virtualmin Manual]:http://www.virtualmin.com/documentation/developer/prepost