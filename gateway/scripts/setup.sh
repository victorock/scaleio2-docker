#!/bin/bash
## FUTURE
## Reload Systemd
# systemctl daemon-reload
# For automation run configuration through puppet
#puppet apply --debug --verbose --color false --detailed-exitcodes \
#/etc/puppet/modules/scaleio2/examples/sio-gateway.pp || [[ $? == 2 ]]

MDMS=""
test -z "${MDM1}" || MDMS="${MDM1}"
test -z "${MDM2}" || MDMS="${MDMS},${MDM2}"
test -z "${MDM3}" || MDMS="${MDMS},${MDM3}"
test -z "$MDMS"   || \
  sed -i 's/mdm.ip.addresses=/mdm.ip.addresses='${MDMS}'/' \
  /opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties

# Life is too short for too much security XD
sed -i 's/gateway-security.allow_non_secure_communication=.*/gateway-security.allow_non_secure_communication=true/' \
  /opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties

sed -i 's/security.bypass_certificate_check=.*/security.bypass_certificate_check=true/' \
    /opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties

## RELOAD services
systemctl restart scaleio-gateway.service
systemctl status scaleio-gateway.service
