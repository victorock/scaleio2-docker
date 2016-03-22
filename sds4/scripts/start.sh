#!/bin/bash
# Install and clean
yum -y install EMC-ScaleIO-sds4.x86_64 && \
  rm -f /var/lib/rpm/__db.* && \
  rpm --rebuilddb && \
  systemctl enable sds.service && \
  systemctl start sds.service && \
  systemctl status sds.service
