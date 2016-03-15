# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-lia-2.0-5014.0.el7.x86_64

FROM victorock/scaleio2:base
MAINTAINER "Victor da Costa" <victorockeiro@gmail.com>

ENV TOKEN "${PASSWORD}"

ADD start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 9099
