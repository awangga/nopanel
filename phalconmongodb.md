# Phalcon And Mongo DB Install
## Phalcon
On windows for development :
1. Using XAMPP PHP 7.4.3
2. Download php_psr.dll 7.4 Thread Safe (TS) x64 : https://pecl.php.net/package/psr/1.0.0/windows
3. Download php_phalcon.dll 7.4 Thread Safe (TS) x64 : https://pecl.php.net/package/phalcon/4.0.2/windows
4. Put php_psr.dll and php_phalcon.dll in \xampp\php\ext directory
5. Edit php.ini search for Dynamic Extensions and put psr and phalcon(make sure psr first before phalcon) extension in the end of block:

```sh
;; Dynamic Extensions ;;

...
...
...

extension=psr
extension=phalcon
```

On Linux :

```sh
# yum install php-devel pcre-devel gcc make
# git clone --depth=1 git://github.com/phalcon/cphalcon.git
# cd cphalcon/build
# ./install
# vi /etc/php.d/phalcon.ini
; Enable phalcon extension module
extension=phalcon.so
# service httpd reload
# php -i | grep phalcon
/etc/php.d/phalcon.ini,
phalcon
phalcon => enabled
phalcon.db.escape_identifiers => On => On
phalcon.db.force_casting => Off => Off
phalcon.orm.cast_on_hydrate => Off => Off
phalcon.orm.column_renaming => On => On
phalcon.orm.enable_implicit_joins => On => On
phalcon.orm.enable_literals => On => On
phalcon.orm.events => On => On
phalcon.orm.exception_on_failed_save => Off => Off
phalcon.orm.ignore_unknown_columns => Off => Off
phalcon.orm.late_state_binding => Off => Off
phalcon.orm.not_null_validations => On => On
phalcon.orm.virtual_foreign_keys => On => On
OLDPWD => /root/cphalcon/build
_SERVER["OLDPWD"] => /root/cphalcon/build
```
### zts-php version

```sh
# mkdir zts
# cd zts
# git clone --depth=1 git://github.com/phalcon/cphalcon.git
# vi /cphalcon/build/install
########## on line 69
########## Perform the compilation
zts-phpize && ./configure --enable-phalcon --with-php-config=zts-php-config && make && make install && echo -e "\nThanks for compiling Phalcon!\nBuild succeed: Please restart your web server to complete the installation" 
# ./install
# service httpd reload
# zts-php -i | grep phalcon
/etc/php-zts.d/phalcon.ini,
phalcon
phalcon => enabled
phalcon.db.escape_identifiers => On => On
phalcon.db.force_casting => Off => Off
phalcon.orm.cast_on_hydrate => Off => Off
phalcon.orm.column_renaming => On => On
phalcon.orm.enable_implicit_joins => On => On
phalcon.orm.enable_literals => On => On
phalcon.orm.events => On => On
phalcon.orm.exception_on_failed_save => Off => Off
phalcon.orm.ignore_unknown_columns => Off => Off
phalcon.orm.late_state_binding => Off => Off
phalcon.orm.not_null_validations => On => On
phalcon.orm.virtual_foreign_keys => On => On
PWD => /root/zts/cphalcon/build
_SERVER["PWD"] => /root/zts/cphalcon/build
```


## MongoDB

```sh
# vi /etc/yum.repos.d/mongodb-org-3.0.repo
# yum install -y mongodb-org
# service mongod start
```

## MongoDB driver

```sh
# yum install re2c
# yum install openssl-devel
# pecl install mongo
# vi /etc/php.d/mongo.ini
extension=mongo.so
# service httpd reload
# php -i | grep mongo
/etc/php.d/mongo.ini,
mongo
mongo.allow_empty_keys => 0 => 0
mongo.chunk_size => 261120 => 261120
mongo.cmd => $ => $
mongo.default_host => localhost => localhost
mongo.default_port => 27017 => 27017
mongo.is_master_interval => 15 => 15
mongo.long_as_object => 0 => 0
mongo.native_long => 1 => 1
mongo.ping_interval => 5 => 5
```
### zts-php version

```sh
# pecl config-show
PHP extension directory        ext_dir          /usr/lib64/php/modules
PHP CLI/CGI binary             php_bin          /usr/bin/php
--program-prefix passed to     php_prefix       <not set>
PHP's ./configure
--program-suffix passed to     php_suffix       <not set>
PHP's ./configure
/usr/bin/zts-php
/usr/lib64/php-zts/modules/
# pecl config-set php_bin /usr/bin/zts-php
# pecl config-set ext_dir /usr/lib64/php-zts/modules/
# pecl config php_prefix zts-    
# pecl install mongo
# service httpd reload
# zts-php -i | grep mongo
/etc/php-zts.d/mongo.ini,
mongo
mongo.allow_empty_keys => 0 => 0
mongo.chunk_size => 261120 => 261120
mongo.cmd => $ => $
mongo.default_host => localhost => localhost
mongo.default_port => 27017 => 27017
mongo.is_master_interval => 15 => 15
mongo.long_as_object => 0 => 0
mongo.native_long => 1 => 1
mongo.ping_interval => 5 => 5
```