#!/bin/bash
# Install and clean
yum -y install EMC-ScaleIO-sds1.x86_64 && \
  rm -f /var/lib/rpm/__db.* && \
  rpm --rebuilddb && \
  systemctl enable sds1.service && \
  systemctl start sds1.service && \
  systemctl status sds1.service
