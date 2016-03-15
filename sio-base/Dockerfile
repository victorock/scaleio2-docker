# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: <none>

FROM centos/c7-systemd
MAINTAINER Victor da Costa <victorockeiro@gmail.com>

ENV container docker
ENV VERSION   "2.0.0"
ENV PASSWORD  "Scaleio123"

ADD start.sh /usr/local/bin/
ADD setup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/{setup,start}.sh
RUN /usr/local/bin/setup.sh
RUN /usr/local/bin/start.sh

VOLUME [ "/etc/puppet", "/dev/shm", "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
