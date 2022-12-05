# dns-constructed seed list

Given connection string :

```
mongodb+srv://ulbi:<passwd>@cluster0.fvazjna.mongodb.net/test
```

Lookup DNS :
```
https://www.nslookup.io/domains/_mongodb._tcp.cluster0.fvazjna.mongodb.net/dns-records/srv/
```

by pass with open vpn

```
route-nopull 
route 34.101.138.77 255.255.255.255
route 34.101.223.114 255.255.255.255
route 34.101.143.99 255.255.255.255
```
