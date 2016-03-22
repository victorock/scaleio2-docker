# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-sds-2.0-5014.0.el7.x86_64

FROM victorock/scaleio2:base
MAINTAINER "Victor da Costa" <victorockeiro@gmail.com>

ENV INSTANCE 4

COPY scripts /usr/local/scripts
RUN chmod +x /usr/local/scripts/*

EXPOSE 7076 25644
VOLUME /dev/shm
