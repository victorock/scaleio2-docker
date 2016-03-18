#!/bin/bash
# Clean rpm locks before puppet run.
# See ticket https://bugs.launchpad.net/fuel/+bug/1339236
rm -f /var/lib/rpm/__db.*
rpm --rebuilddb

# Run puppet to apply custom config
systemctl daemon-reload

# Install MDM
# Dependence of systemd and volume for configuration persistence
yum -y install EMC-ScaleIO-sds"${INSTANCE}".x86_64

## FUTURE
# For automation run configuration through puppet
#puppet apply --debug --verbose --color false --detailed-exitcodes \
#/etc/puppet/modules/scaleio2/examples/sio-sds.pp || [[ $? == 2 ]]

# Confirm service is started correctly
systemctl enable sds.service
systemctl start sds.service
systemctl status sds.service
