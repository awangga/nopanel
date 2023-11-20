# PostgreSQL Instalation and Maintenance


Tunneling to PostgreSQL via proxy, scipt:

```sh
#!/bin/sh
while :
do
  /root/.fly/bin/flyctl proxy 5432 -a whatsauth
done
```
