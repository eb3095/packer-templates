#!/bin/bash

cd /tmp
wget https://ewr1.vultrobjects.com/cloud_init_beta/cloud-init_ubuntu_latest.deb
md5sum cloud-init_ubuntu_latest.deb > /tmp/cloud-init_ubuntu_latest.md5sum

apt-get -y install python3-jinja2
apt-get -y install python3-jsonpatch
apt-get -y install python3-jsonschema
dpkg -i cloud-init_ubuntu_latest.deb
apt-get install -f -y
