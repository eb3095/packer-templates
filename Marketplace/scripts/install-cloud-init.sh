#!/bin/bash

cd /tmp
wget https://ewr1.vultrobjects.com/cloud_init_beta/cloud-init_universal_latest.deb
md5sum cloud-init_universal_latest.deb

dpkg -i cloud-init_universal_latest.deb
apt-get install -f -y

sleep 5

mkdir -p /var/lib/cloud/scripts/per-instance/
mv /tmp/provision.sh /var/lib/cloud/scripts/per-instance/provision.sh
chmod +x /var/lib/cloud/scripts/per-instance/provision.sh
