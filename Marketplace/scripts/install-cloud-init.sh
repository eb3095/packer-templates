#!/bin/bash

cd /tmp
wget https://ewr1.vultrobjects.com/cloud_init_beta/cloud-init_universal_latest.deb
md5sum cloud-init_universal_latest.deb

apt update -y

dpkg -i cloud-init_universal_latest.deb
apt-get install -f -y
