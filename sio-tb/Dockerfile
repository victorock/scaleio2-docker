# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-mdm-2.0-5014.0.el7.x86_64

FROM victorock/sio-base
MAINTAINER "Victor da Costa" <victorockeiro@gmail.com>

ENV MDM_ROLE_IS_MANAGER 0

ADD config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/config.sh

RUN yum -y install EMC-ScaleIO-mdm.x86_64
RUN systemctl enable mdm.service
RUN systemctl restart mdm.service

EXPOSE 6611 9011 25600
