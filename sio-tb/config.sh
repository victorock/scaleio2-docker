#!/bin/bash
puppet apply --debug --verbose --color false --detailed-exitcodes \
/etc/puppet/modules/scaleio2/examples/fuel-sio-mdm.pp || [[ $? == 2 ]]
