# dns-constructed seed list

Given connection string :

```
mongodb+srv://ulbi:<passwd>@cluster0.fvazjna.mongodb.net/test
```

Lookup DNS :
```
https://www.nslookup.io/domains/_mongodb._tcp.cluster0.fvazjna.mongodb.net/dns-records/srv/
```

by pass with open vpn, add http://ip-api.com/json(208.95.112.1) to check VPN Public IP Address

```
route-nopull 
route 34.101.138.77 255.255.255.255
route 34.101.223.114 255.255.255.255
route 34.101.143.99 255.255.255.255
route 208.95.112.1 255.255.255.255
```
