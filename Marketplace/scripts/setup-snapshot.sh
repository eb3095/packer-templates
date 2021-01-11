#!/bin/bash

echo "" > /var/log/auth.log
echo "" > /var/root/.bash_history

# update mlocate db
/usr/bin/updatedb

# wipe random seed files
rm -f /var/lib/systemd/random-seed

# wipe machine id, systemd refuses to boot without this file ( https://bbs.archlinux.org/viewtopic.php?id=156651 )
rm -f /etc/machine-id
touch /etc/machine-id

# Create script folders for cloud-init
mkdir -p /var/lib/cloud/scripts/per-instance/
mkdir -p /var/lib/cloud/scripts/per-boot/

# Install scripts
mv /tmp/per-instance-provision.sh /var/lib/cloud/scripts/per-instance/provision.sh
mv /tmp/per-boot-setup.sh /var/lib/cloud/scripts/per-boot/setup.sh

# Make executable
chmod +x /var/lib/cloud/scripts/per-instance/provision.sh
chmod +x /var/lib/cloud/scripts/per-boot/setup.sh
