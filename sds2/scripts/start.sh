#!/bin/bash
# Install and clean
yum -y install EMC-ScaleIO-sds2.x86_64 && \
  rm -f /var/lib/rpm/__db.* && \
  rpm --rebuilddb && \
  systemctl enable sds2.service && \
  systemctl start sds2.service && \
  systemctl status sds2.service
