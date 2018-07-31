#! /bin/bash
set -x
cat /opt/.env >> /etc/environment
sudo yum check-update
curl -fsSL https://get.docker.com/ | sh
sudo systemctl start docker
sudo yum install -y epel-release
sudo yum install -y python-pip
sudo pip install docker-compose
docker pull drone/drone:0.8
mkdir /var/lib/drone
cd /opt/
docker-compose up -d