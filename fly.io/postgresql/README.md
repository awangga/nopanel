# PostgreSQL Installation and Maintenance
Create PostgreSQL server with appname :
```sh
/root/.fly/bin/flyctl auth login
/root/.fly/bin/fly postgres create
/root/.fly/bin/flyctl postgres connect -a appname
/root/.fly/bin/flyctl proxy 5432 -a appname 
/root/.fly/bin/flyctl postgres restart -a appname
```

Tunneling to PostgreSQL via proxy, db.sh script:

```sh
#!/bin/sh
while :
do
  /root/.fly/bin/flyctl proxy 5432 -a whatsauth
done
```
add into crontab to start in startup server 
```sh
crontab -e
@reboot /root/db.sh
```
