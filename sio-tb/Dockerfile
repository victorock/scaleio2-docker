# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-mdm-2.0-5014.0.el7.x86_64

FROM victorock/scaleio2:mdm
MAINTAINER "Victor da Costa" <victorockeiro@gmail.com>

ENV MDM_ROLE_IS_MANAGER 0

ADD start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 6611 9011 25600
