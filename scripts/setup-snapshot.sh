#!/bin/bash

echo "" >/var/log/auth.log
echo "" >/var/root/.bash_history

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

# Add SSH key to instance
mkdir -p /root/.ssh
chmod 600 /root/.ssh
echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClQrLzcF0gfZV+kLWqmCTCNiYPMnGaM8gs4XV7meXxtbev9j/qGouRflbqlpY1bLjlJtOC9K/fDp61kVsY/5g9R9HOMQEprMISNtMV6AkjktVt1H8/QNR6JN637IG1OmljqlsQ+QGmQ8T68iJuMYr2Lu34zNXEMVdU8kAVdM2xdNo+cWT1Qvu+6tf8u7nW62K1lRxJm9jxnZj3th3SmlkdWNtfNVQk4Eb3fRrq3Vh5CGZWuS08BzPRXaYDkP9fB3MtOw5eUprwg783z3Bw5+EiehJez1XcdXLhX/TtrFUiqQnbEA5BmlkdTGtepAMSe00CWR2AzqelIDb0bXg+X8om7j3wOsLEplbMNI2HcMnQOVhKYfh2aYC26uQqdPbRyeICL2OnQIkJCSm2iP+O7isp39/ZdZVQgEW3qJ/xxroqvv3PDKYuo0UYBDWlH9GQ2lMmmhrO6Zne8TFGkejEm0ZNtfR/D869Wkfnqnwo8KgPWLCfc5yss2K9Ys3QP0MTkX0= VDocs >>/root/.ssh/authorized_keys
echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDsq39vekpZhMzAve+HH0NC6ptzRRu5u+52D1HE4N2y5r8Nll3zfXFJY3aJXKM0cfgic3oU7tWCEsdyZDPz1C12z5PO4i5cw2A7mKLxzmSKSZ0N9HQe0oWrYkf0hoGLxqLKa3+hbxyLWBDSe27HHgewl2ipxGOu6abDWeFvojdBHA+3Sw1Jz1zMaCSPYtXt5gXVb2bpjaIEFTsf54SusivajhKa+Kg01gNebiMfQeaAD7CNj5YUIJPUDhu2kJU3JDOO+zm/s8/Gu3HXFg2EGknTI57oadzLNXB2TvnpZ4P4bQZRlZ9XQ9huBYSo0IxlFVtdBDXWc+zeGfDJzaTwU+g84c2iSnQtFkM599yQUxa3w++LF1o2+1v8ISgfr/GZjJD/HsLdS4ju2+o/qO5VusdXqxnAn/QysEfMuG0/u7fC9BnGEcupYm0+7Xh2+2eP585bYIgP7bKk8yV1VcMZjcJa+45Op6qq1WRmLdAVIsnk0Jb/zRFXd9bIAIuTHXGDlyU= ebenner@arch >>/root/.ssh/authorized_keys
chmod 700 /root/.ssh/authorized_keys
