#!bin/bash

curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt-get update
apt-get install gitlab-ce
gitlab-ctl reconfigure


