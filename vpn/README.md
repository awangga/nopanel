# Set Up VPN Server and Client

Easy Set Up VPN Server and Client

## Server

1. Download [latest X-Ray Core](https://github.com/XTLS/Xray-core/releases) or just use [Docker Image](https://github.com/xtls/Xray-core/pkgs/container/xray-core)
2. Download into the xray folder and set [config.json](config.json) file
3. Run xray or xray.exe inside folder xray
4. If you don't have IP Public, use with [cloudflare tunnel script](run.bat) or just run: cloudflared tunnel run id
5. If you have Public IP you might use nginx with proxy pass feature config:
   ```conf
   server {
        listen 443 ssl;
        server_name  sub.domain.com;
        ssl_certificate     www.example.com.crt;
        ssl_certificate_key www.example.com.key;

        client_max_body_size 100M;
        location / {# if you have any website service
            proxy_pass http://127.0.0.1:3000;
            proxy_set_header X-Real-IP  $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
        }

        location /ws/ {#if you have any websocket service
        proxy_set_header   X-Forwarded-For $remote_addr;
        proxy_http_version 1.1;
        proxy_set_header   Host $http_host;
        proxy_set_header Upgrade websocket;
        proxy_set_header Connection Upgrade;
        proxy_pass         http://127.0.0.1:4000;
        }

        location /lawang {#vpn path
              if ($http_upgrade != "websocket") {
                  return 404;
              }
              proxy_redirect off;
              proxy_pass http://127.0.0.1:8080;
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";
              proxy_set_header Host $http_host;
              # Show real IP in v2ray access.log
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            }
   }
   ```

## Client

The easy way to connect to a VPN by using [Nekoray](https://github.com/MatsuriDayo/nekoray)

Please set:
* Port: 443
* UUID: 08a5d7ec-45d7-4928-9bd6-d9bd97c00cde
* Host and Address: your cloudflared tunneled domain or nginx vhost sub domain
* Path: /lawang

![image](https://github.com/netpedia/netpedia.github.io/assets/11188109/0c22d5f4-b1f3-4a77-a610-b54c56d38ea5)

![image](https://user-images.githubusercontent.com/11188109/235293800-39022689-3926-4f4e-9de2-669a797bf994.png)

![image](https://github.com/netpedia/netpedia.github.io/assets/11188109/6cea5bac-fdf0-49e0-9e16-9cc2e311b093)
