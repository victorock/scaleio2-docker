#!/bin/bash
puppet apply --debug --verbose --color false --detailed-exitcodes \
/etc/puppet/modules/scaleio2/examples/fuel-sio-lia.pp || [[ $? == 2 ]]
