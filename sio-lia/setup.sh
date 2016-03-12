#!/bin/bash
cat << EOF > /etc/yum.repos.d/nailgun.repo
#bintraybintray-victorock-rpm - packages by victorock from Bintray
[bintraybintray-victorock]
name=bintray-victorock
baseurl=https://dl.bintray.com/victorock/rpm
gpgcheck=0
enabled=1
EOF

yum -y install epel-release yum-utils libaio numactl openssl openssl-devel puppet java-1.8.0-openjdk

TOKEN='Scaleio123' yum -y install EMC-ScaleIO-lia.x86_64
