#!/bin/bash
# Clean rpm locks before puppet run.
# See ticket https://bugs.launchpad.net/fuel/+bug/1339236
rm -f /var/lib/rpm/__db.*
rpm --rebuilddb

# Run puppet to apply custom config
systemctl daemon-reload

# INSTALL SDS
yum -y install EMC-ScaleIO-sds.x86_64

## FUTURE
# For automation run configuration through puppet
#puppet apply --debug --verbose --color false --detailed-exitcodes \
#/etc/puppet/modules/scaleio2/examples/sio-sds.pp || [[ $? == 2 ]]
