# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-gateway-2.0-5014.0.x86_64
FROM centos:c7-systemd
MAINTAINER Victor da Costa <victorockeiro@gmail.com>

RUN yum -y install epel-release yum-utils
RUN yum-config-manager --add-repo https://bintray.com/victorock/rpm/rpm
RUN yum-config-manager --enable bintraybintray-victorock-rpm
RUN GATEWAY_ADMIN_PASSWORD='Scaleio123' yum -y install EMC-ScaleIO-gateway.x86_64
RUN systemctl enable scaleio-gateway.service

EXPOSE 80 443
CMD [“/usr/sbin/init”]
