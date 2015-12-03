# Phalcon And Mongo DB Install
## Open terminal

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