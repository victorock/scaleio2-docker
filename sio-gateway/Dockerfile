# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-gateway-2.0-5014.0.x86_64

FROM victorock/sio-base
MAINTAINER "Victor da Costa" <victorockeiro@gmail.com>

ENV GATEWAY_ADMIN_PASSWORD "Scaleio123"
ENV SIO_GW_JAVA "/usr/lib/jvm"

ADD config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/config.sh

RUN yum -y install EMC-ScaleIO-gateway.x86_64
RUN systemctl enable scaleio-gateway.service
RUN systemctl restart scaleio-gateway.service

EXPOSE 80 443
