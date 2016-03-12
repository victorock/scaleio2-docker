# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-lia-2.0-5014.0.el7.x86_64
FROM centos:c7-systemd
MAINTAINER Victor da Costa <victorockeiro@gmail.com>

ADD etc /etc
ADD start.sh /usr/local/bin/
ADD setup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/{setup,start}.sh

EXPOSE 9099
CMD [“/usr/sbin/init”]
