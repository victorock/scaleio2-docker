# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-mdm-2.0-5014.0.el7.x86_64
FROM centos:c7-systemd
MAINTAINER Victor da Costa <victorockeiro@gmail.com>

RUN yum -y install epel-release yum-utils
RUN yum-config-manager --add-repo https://bintray.com/victorock/rpm/rpm
RUN yum-config-manager --enable bintraybintray-victorock-rpm
RUN MDM_ROLE_IS_MANAGER=0 yum -y install EMC-ScaleIO-mdm.x86_64
RUN systemctl enable mdm.service
EXPOSE 6611 9011 25600
CMD [“/usr/sbin/init”]
