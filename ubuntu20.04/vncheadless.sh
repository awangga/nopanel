sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install gnome-shell
sudo apt-get -y install ubuntu-gnome-desktop
sudo apt-get -y install autocutsel
sudo apt-get -y install gnome-core
sudo apt-get -y install gnome-panel
sudo apt-get -y install gnome-themes-standard

sudo apt-get -y install tightvncserver
touch ~/.Xresources
tightvncserver
vncserver -kill :1
vim ~/.vnc/xstartup
vncserver -geometry 1680x1050
