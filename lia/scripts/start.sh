#!/bin/bash
# Install and clean
yum -y install EMC-ScaleIO-lia.x86_64 && \
  rm -f /var/lib/rpm/__db.* && \
  rpm --rebuilddb && \
  systemctl enable lia.service && \
  systemctl restart lia.service && \
  systemctl status lia.service
