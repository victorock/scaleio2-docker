#!/bin/bash
# Install and clean
yum -y install EMC-ScaleIO-mdm.x86_64 && \
  rm -f /var/lib/rpm/__db.* && \
  rpm --rebuilddb && \
  systemctl enable mdm.service && \
  systemctl start mdm.service && \
  systemctl status mdm.service
