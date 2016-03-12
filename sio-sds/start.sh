#!/bin/bash

# Clean rpm locks before puppet run.
# See ticket https://bugs.launchpad.net/fuel/+bug/1339236
rm -f /var/lib/rpm/__db.*
rpm --rebuilddb

# Run puppet to apply custom config
systemctl daemon-reload

puppet apply --debug --verbose --color false --detailed-exitcodes \
/etc/puppet/modules/scaleio2/examples/fuel-sio-sds.pp || [[ $? == 2 ]]

systemctl enable sds.service
systemctl restart sds.service
