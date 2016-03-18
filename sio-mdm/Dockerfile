# VERSION               0.1
#
# Installs SCALEIO 2.0
# Packages: EMC-ScaleIO-mdm-2.0-5014.0.el7.x86_64

FROM victorock/scaleio2:base
MAINTAINER "Victor da Costa" <victorockeiro@gmail.com>

ENV PASSWORD            "Scaleio123"
ENV MDM_ROLE_IS_MANAGER 1

ENV MDM1                ""
ENV MDM1_NAME           ""

ENV MDM2                ""
ENV MDM2_NAME           ""

ENV MDM3                ""
ENV MDM3_NAME           ""

ENV TB1                 ""
ENV TB1_NAME            ""

ENV TB2                 ""
ENV TB2_NAME            ""

COPY scripts /usr/local/scripts
RUN chmod +x /usr/local/scripts/*

EXPOSE 6611 9011 25620
CMD ["/usr/sbin/init"]
