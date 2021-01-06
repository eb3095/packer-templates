#!/bin/bash

cd /tmp
wget https://ewr1.vultrobjects.com/cloud_init_beta/cloud-init_ubuntu_latest.deb
md5sum cloud-init_ubuntu_latest.deb

apt-get -y install python3-jinja2
apt-get -y install python3-jsonpatch
apt-get -y install python3-jsonschema
dpkg -i cloud-init_ubuntu_latest.deb
apt-get install -f -y

systemctl start cloud-init
sleep 5

mv /tmp/provision.sh /var/lib/cloud/scripts/per-instance/provision.sh
chmod +x /var/lib/cloud/scripts/per-instance/provision.sh
