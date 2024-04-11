# Set Up VPN Server and Client

Easy Set Up VPN Server and Client

## Server

1. Download [latest X-Ray Core](https://github.com/XTLS/Xray-core/releases) or just use [Docker Image](https://github.com/xtls/Xray-core/pkgs/container/xray-core)
2. Download into the xray folder and set [config.json](config.json) file
3. Run xray or xray.exe inside folder xray
4. If you don't have IP Public, use with [cloudflare tunnel script](run.bat) or just run: cloudflared tunnel run id

## Client

The easy way to connect to a VPN by using [Nekoray](https://github.com/MatsuriDayo/nekoray)

Please set:
* Port : 443
* UUID : 08a5d7ec-45d7-4928-9bd6-d9bd97c00cde
* Host and Address : your cloudflared tunneled domain
* Path : /lawang

![image](https://github.com/netpedia/netpedia.github.io/assets/11188109/0c22d5f4-b1f3-4a77-a610-b54c56d38ea5)

![image](https://user-images.githubusercontent.com/11188109/235293800-39022689-3926-4f4e-9de2-669a797bf994.png)

![image](https://github.com/netpedia/netpedia.github.io/assets/11188109/6cea5bac-fdf0-49e0-9e16-9cc2e311b093)
