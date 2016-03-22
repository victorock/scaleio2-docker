#!/bin/bash
# Install and clean
yum -y install EMC-ScaleIO-sds3.x86_64 && \
  rm -f /var/lib/rpm/__db.* && \
  rpm --rebuilddb && \
  systemctl enable sds3.service && \
  systemctl start sds3.service && \
  systemctl status sds3.service
