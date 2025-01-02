# Remote X11
Alokasi swap

```sh
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

tanpa windows manager

```sh
sudo apt install -y xorg x11vnc xvfb
ps aux | grep Xvfb
kill -9
sudo rm -f /tmp/.X0-lock
echo $DISPLAY
export DISPLAY=:0
Xvfb :0 -screen 0 1920x1080x16
x11vnc -display :0 -forever -usepw

export DISPLAY=:0
./lightningcashr-qt
```
