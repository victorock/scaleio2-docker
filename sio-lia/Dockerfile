# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-lia-2.0-5014.0.el7.x86_64
FROM centos:c7-systemd
MAINTAINER Victor da Costa <victorockeiro@gmail.com>

RUN yum -y install epel-release yum-utils
RUN yum-config-manager --add-repo https://bintray.com/victorock/rpm/rpm
RUN yum-config-manager --enable bintraybintray-victorock-rpm
RUN yum -y install numactl libaio openssl openssl-devel
RUN yum -y install TOKEN='Scaleio123' EMC-ScaleIO-lia.x86_64
RUN systemctl enable lia.service
EXPOSE 9099
CMD [“/usr/sbin/init”]
