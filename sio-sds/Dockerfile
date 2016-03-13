# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-sds-2.0-5014.0.el7.x86_64

FROM victorock/sio-base
MAINTAINER "Victor da Costa" <victorockeiro@gmail.com>

ADD config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/config.sh

RUN yum -y install EMC-ScaleIO-sds.x86_64
RUN systemctl enable sds.service
RUN systemctl restart sds.service

EXPOSE 7072-7076 25640-25644
