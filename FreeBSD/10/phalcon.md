# Looking open port
sockstat -4 -l
# Instalation
portsnap fetch update
cd /usr/ports/www/nginx/
make install clean
# REWRITE_MODULE, SSL_MODULE 
pkg install nginx
echo 'nginx_enable="YES"' >> /etc/rc.conf
service nginx start


cd /usr/ports/lang/php5 && make install clean
# FPM
cd /usr/ports/lang/php5-extensions && make install
CURL, GD, IMAP, MBSTRING, MCRYPT, MySQL, MySQLi, OPENSSL, PDO_MySQL, ZIP, ZLIB



cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini
ee /usr/local/etc/php.ini
```sh
output_buffering = 4096
;session.save_path = "/tmp"
upload_max_filesize = 2M
post_max_size = 8M
date.timezone = America/Los_Angeles
```

```sh
output_buffering = OFF
session.save_path = "/tmp"
upload_max_filesize = 5120M
post_max_size = 5120M
date.timezone = America/New_York
```

ee /usr/local/etc/php-fpm.conf
```sh
[global]
pid = run/php-fpm.pid

[PYDIO]
listen = /var/run/phph-fpm.socket
listen.owner = www
listen.group = www
listen.mode = 0666

listen.backlog = -1
listen.allowed_clients = 127.0.0.1

user = www
group = www

pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
pm.max_requests = 500

env[HOSTNAME] = $HOSTNAME
env[PATH] = /usr/local/bin:/usr/bin:/bin
env[TMP] = /tmp
env[TMPDIR] = /tmp
env[TEMP] = /tmp

```


ee /usr/local/etc/nginx/fastcgi_params
```sh
fastcgi_param  QUERY_STRING       $query_string;
fastcgi_param  REQUEST_METHOD     $request_method;
fastcgi_param  CONTENT_TYPE       $content_type;
fastcgi_param  CONTENT_LENGTH     $content_length;

fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;
fastcgi_param  REQUEST_URI        $request_uri;
fastcgi_param  DOCUMENT_URI       $document_uri;
fastcgi_param  DOCUMENT_ROOT      $document_root;
fastcgi_param  SERVER_PROTOCOL    $server_protocol;
fastcgi_param  HTTPS              $https if_not_empty;

fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
fastcgi_param  SERVER_SOFTWARE    nginx/$nginx_version;

fastcgi_param  REMOTE_ADDR        $remote_addr;
fastcgi_param  REMOTE_PORT        $remote_port;
fastcgi_param  SERVER_ADDR        $server_addr;
fastcgi_param  SERVER_PORT        $server_port;
fastcgi_param  SERVER_NAME        $server_name;

# PHP only, required if PHP was built with --enable-force-cgi-redirect
fastcgi_param  REDIRECT_STATUS    200;
```

service php-fpm start

ee /usr/local/etc/nginx/nginx.conf
