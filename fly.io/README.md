# Fly.io Script
Install
```sh
curl -L https://fly.io/install.sh | sh
export FLYCTL_INSTALL="/home/awangga/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
fly auth login
```
## CI/CD Github
```sh
fly tokens create deploy -x 999999h
```
![image](https://github.com/awangga/nopanel/assets/11188109/84e3da90-4ff3-4945-8277-3df6c5cd3d03)  
create file .github/workflows/fly.yml :
```yml
name: Fly Deploy
on:
  push:
    branches:
      - main
jobs:
  deploy:
    name: Deploy app
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: superfly/flyctl-actions/setup-flyctl@master
      - run: flyctl deploy --remote-only
        env:
          FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}
```


## SSH
Connect SSH Server:
```sh
/root/.fly/bin/fly ssh console -s -a appname
```
## Port Forward
to forward port from new port using socat, for example forward 2096 to 5432
```sh
socat -dddd TCP4-LISTEN:2096,reuseaddr,fork TCP4:127.0.0.1:5432
```
## SSL Custom domain
run
```sh
fly certs add fly.wa.my.id
fly certs show fly.wa.my.id
```

## Cloudflare DDNS Dynamic IP

First install jq:
```sh
curl text.ipv6.wtfismyip.com
apt install jq
```

Create script ip.sh to update IPV6 :
```sh
#!/bin/bash

## Define your Cloudflare API key token
CLOUDFLARE_API_KEY=tokenfromrequestapi

## Define the domain and record ID you want to update
DOMAIN=32bitkeyfromdomaindashboard
NAME=subdomain.tld.name

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
