#!/bin/bash
cat << EOF > /etc/yum.repos.d/bintray-victorock-scaleio.repo
#bintraybintray-victorock-rpm - packages by victorock from Bintray
[bintray-victorock-scaleio]
name=bintray-victorock-scaleio
baseurl=https://dl.bintray.com/victorock/scaleio/centos/\$releasever/x86_64/
gpgcheck=0
enabled=1
EOF

yum -y install epel-release
yum -y install tar wget mutt python python-paramiko libaio numactl openssl \
  openssl-devel puppet java-1.8.0-openjdk initscripts

#puppet module install puppetlabs-firewall
#puppet module install puppetlabs-java
#puppet module install dalen-dnsquery
#puppet module install puppetlabs-stdlib
#puppet module install victorock-scaleio2
