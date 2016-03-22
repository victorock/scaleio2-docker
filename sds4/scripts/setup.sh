#!/bin/bash
## FUTURE
## Reload Systemd
# systemctl daemon-reload
# For automation run configuration through puppet
#puppet apply --debug --verbose --color false --detailed-exitcodes \
#/etc/puppet/modules/scaleio2/examples/sio-sds.pp || [[ $? == 2 ]]

# Discover disks
# Send the list of disks to discovery service
fdisk -l | grep Disk | grep sectors | cut -d':' -f1 | cut -d' ' -f2 | egrep '(sd|vd|xd|rb)[a-z]'
