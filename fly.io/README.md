# Fly.io Script
Connect SSH Server:
```sh
/root/.fly/bin/fly ssh console -s -a appname
```
## Port Forward
to forward port from new port using socat, for example forward 2096 to 5432
```sh
socat -dddd TCP4-LISTEN:2096,reuseaddr,fork TCP4:127.0.0.1:5432
```

## Cloudflare DDNS Dynamic IP

Create script ip.sh to update IPV6 :
```sh
#!/bin/bash

## Define your Cloudflare API key token
CLOUDFLARE_API_KEY=tokenfromrequestapi

## Define the domain and record ID you want to update
DOMAIN=32bitkeyfromdomaindashboard
NAME=subdomain.tld.id

## Get Record ID sub domain to update using this curl request
#curl -s https://api.cloudflare.com/client/v4/zones/$DOMAIN/dns_records \
#  -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
#  -H "Content-Type: application/json"
RECORD=subdomainidfromrequestabove

## Get the current public IP address
IP=$(curl -s https://cloudflare.com/cdn-cgi/trace | grep -E '^ip' | cut -d = -f 2)

## Get the current IP address on Cloudflare
CF_IP=$(curl -s https://api.cloudflare.com/client/v4/zones/$DOMAIN/dns_records/$RECORD \
  -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
  -H "Content-Type: application/json" \
  | jq '.result.content' \
  | tr -d \")

printf "IP CF $CF_IP || IP VM $IP\n"

## Update the IP address on Cloudflare if it has changed
if [ "$IP" != "$CF_IP" ]; then
  printf "update api $CF_IP \n"
  curl -s https://api.cloudflare.com/client/v4/zones/$DOMAIN/dns_records/$RECORD \
    -X PUT \
    -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"A\",\"name\":\"$NAME\",\"content\":\"$IP\"}"
fi
```
