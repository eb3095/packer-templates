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