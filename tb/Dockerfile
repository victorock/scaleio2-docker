# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-mdm-2.0-5014.0.el7.x86_64

FROM victorock/scaleio2:base
MAINTAINER "Victor da Costa" <victorockeiro@gmail.com>

ENV MDM_ROLE_IS_MANAGER 0

COPY scripts /usr/local/scripts
RUN chmod +x /usr/local/scripts/*

EXPOSE 6611 9011 25600
VOLUME /dev/shm
