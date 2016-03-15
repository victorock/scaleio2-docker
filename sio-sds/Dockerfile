# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-sds-2.0-5014.0.el7.x86_64

FROM victorock/scaleio2:base
MAINTAINER "Victor da Costa" <victorockeiro@gmail.com>

ADD start.sh /usr/local/bin/
ADD setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/{setup,start}.sh

EXPOSE 7072-7076 25640-25644
