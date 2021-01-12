#!/bin/bash

echo $(date -u) System provisioned >> /root/per-instance.log
rm -f /opt/vultr/marketplace/provision.sh

