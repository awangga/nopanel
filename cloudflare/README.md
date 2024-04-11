# Cloudflare
Installation
```powershell
winget install --id Cloudflare.cloudflared
```
## Tunnel

Instant Tunnel
```powershell
cloudflared tunnel --url 192.168.1.222:443
```

Logged In Tunnel
```powershell
cloudflared tunnel login
cloudflared tunnel create docker
cloudflared tunnel list
cloudflared tunnel route dns docker docker.ulbi.ac.id
```

creaate config.yml inside .cloudflared folder
```yml
url: http://10.14.200.20
tunnel: 7cbb68b2-07ec-414a-bf60-2666aeeaaa2c
credentials-file: C:\Users\LENOVO\.cloudflared\7cbb68b2-07ec-414a-bf60-2666aeeaaa2c.json
```
run again
```powershell
cloudflared tunnel run docker
```
