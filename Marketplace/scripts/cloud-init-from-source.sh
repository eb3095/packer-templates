#!/bin/bash

cd /tmp
git clone -b vultr https://github.com/eb3095/cloud-init.git
cd cloud-init

apt-get update -y
apt-get upgrade -y
apt-get install -y python3-pip 

pip3 install setuptools
pip3 install -r requirements.txt
python3 setup.py build
python3 setup.py install --init-system systemd

ln -s /usr/local/bin/cloud-init /usr/bin/cloud-init

chattr -i /etc/udev/rules.d/70-persistent-net.rules

systemctl enable cloud-init-local.service
systemctl enable cloud-init.service
systemctl enable cloud-config.service
systemctl enable cloud-final.service

systemctl start cloud-init
sleep 5

mv /tmp/provision.sh /var/lib/cloud/scripts/per-instance/provision.sh
chmod +x /var/lib/cloud/scripts/per-instance/provision.sh
