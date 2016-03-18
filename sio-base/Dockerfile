# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: <none>

FROM centos/c7-systemd
MAINTAINER Victor da Costa <victorockeiro@gmail.com>

ENV container docker
ENV VERSION   "2.0.0"
ENV PASSWORD  "Scaleio123"

# ScaleIO Repository
COPY config/bintray-victorock-scaleio.repo /etc/yum.repos.d/

# RPM Manipulation
RUN yum -y update && \
  yum -y install epel-release && \
  yum -y install  \
  initscripts \
  java-1.8.0-openjdk-devel \
  libaio \
  mutt \
  numactl \
  openssl \
  openssl-devel \
  puppet \
  python \
  python-paramiko \
  tar  \
  wget && \
  rm -f /var/lib/rpm/__db.* && \
  rpm --rebuilddb

RUN mkdir -p /opt/emc/scaleio/{mdm,sds,sds1,sds2,sds3,sds4,gateway,lia}/cfg

VOLUME /opt/emc/scaleio/sds
VOLUME /opt/emc/scaleio/sds1
VOLUME /opt/emc/scaleio/sds2
VOLUME /opt/emc/scaleio/sds3
VOLUME /opt/emc/scaleio/sds4
VOLUME /opt/emc/scaleio/mdm
VOLUME /opt/emc/scaleio/gateway
VOLUME /opt/emc/scaleio/lia
VOLUME /etc/puppet

CMD ["/usr/sbin/init"]
