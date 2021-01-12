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
mkdir -p /opt/vultr/marketplace/
mkdir -p /var/lib/cloud/scripts/per-boot/

# Install scripts
mv /tmp/per-instance-provision.sh /opt/vultr/marketplace/provision.sh
mv /tmp/per-boot-setup.sh /var/lib/cloud/scripts/per-boot/setup.sh

# Make executable
chmod +x /opt/vultr/marketplace/provision.sh
chmod +x /var/lib/cloud/scripts/per-boot/setup.sh

# Add SSH key to instance
mkdir -p /root/.ssh
chmod 600 /root/.ssh
echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClQrLzcF0gfZV+kLWqmCTCNiYPMnGaM8gs4XV7meXxtbev9j/qGouRflbqlpY1bLjlJtOC9K/fDp61kVsY/5g9R9HOMQEprMISNtMV6AkjktVt1H8/QNR6JN637IG1OmljqlsQ+QGmQ8T68iJuMYr2Lu34zNXEMVdU8kAVdM2xdNo+cWT1Qvu+6tf8u7nW62K1lRxJm9jxnZj3th3SmlkdWNtfNVQk4Eb3fRrq3Vh5CGZWuS08BzPRXaYDkP9fB3MtOw5eUprwg783z3Bw5+EiehJez1XcdXLhX/TtrFUiqQnbEA5BmlkdTGtepAMSe00CWR2AzqelIDb0bXg+X8om7j3wOsLEplbMNI2HcMnQOVhKYfh2aYC26uQqdPbRyeICL2OnQIkJCSm2iP+O7isp39/ZdZVQgEW3qJ/xxroqvv3PDKYuo0UYBDWlH9GQ2lMmmhrO6Zne8TFGkejEm0ZNtfR/D869Wkfnqnwo8KgPWLCfc5yss2K9Ys3QP0MTkX0= VDocs >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh/authorized_keys
