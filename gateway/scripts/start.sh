#!/bin/bash
# Install and clean
yum -y install EMC-ScaleIO-gateway.x86_64 && \
  rm -f /var/lib/rpm/__db.* && \
  rpm --rebuilddb && \
  systemctl enable scaleio-gateway-wd.service && \
  systemctl daemon-reload && \
  systemctl restart scaleio-gateway-wd.service && \
  systemctl enable scaleio-gateway.service && \
  systemctl restart scaleio-gateway.service && \
  systemctl status scaleio-gateway.service
