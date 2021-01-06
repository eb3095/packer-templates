#!/bin/bash

MDTKPASSWD=$(openssl rand -base64 32)

echo $MDTKPASSWD >> /root/mdtk-password

useradd -m -p $MDTKPASSWD mdtk
usermod -aG sudo mdtk

apt-get update -y
apt-get upgrade -y
apt-get install -y nginx
apt-get install -y certbot python3-certbot-nginx

/bin/cat <<EOM > /etc/nginx/sites-available/code-server
server {
    listen 80;
    listen [::]:80;
    server_name _;

    location / {
    proxy_pass http://localhost:8080/;
    proxy_set_header Host \$host;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection upgrade;
    proxy_set_header Accept-Encoding gzip;
    }
}
EOM

ln -s /etc/nginx/sites-available/code-server /etc/nginx/sites-enabled/code-server
rm /etc/nginx/sites-enabled/default

cd /tmp
wget https://github.com/errata-ai/vale/releases/download/v2.6.8/vale_2.6.8_Linux_64-bit.tar.gz
tar -xzf vale_2.6.8_Linux_64-bit.tar.gz
mv vale /usr/local/bin

cd /home/mdtk

sudo -i -u mdtk curl -fsSL https://code-server.dev/install.sh | sh
systemctl enable --now code-server@mdtk

sudo -i -u mdtk git clone https://github.com/vultr/vultr-mdtk.git
