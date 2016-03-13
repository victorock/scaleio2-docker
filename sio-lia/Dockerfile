# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-lia-2.0-5014.0.el7.x86_64

FROM victorock/sio-base
MAINTAINER "Victor da Costa" <victorockeiro@gmail.com>

ENV TOKEN "Scaleio123"

ADD config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/config.sh

RUN yum -y install EMC-ScaleIO-lia.x86_64
RUN systemctl enable lia.service
RUN systemctl restart lia.service

EXPOSE 9099
