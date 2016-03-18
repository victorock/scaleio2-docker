
# Containers to run ScaleIO
The configuration of ScaleIO is not embedded in the container.
Puppet is installed inside of the containers.
Please, consider using puppet-scaleio2 if you would like to proceed with
automation/configuration.

Installation procedure:
Host1: MDM1, GW, SDS (optional)
Host2: MDM2, GW, SDS (optional)
Host3: TB1, GW, SDS (optional)

The data resides within the container, so consider mounting external /opt/emc
inside of the container for data persistence and facilitate upgrades.

# Host1
## MDM1
### RUN
  docker run -d \
    --privileged \
    -P \
    --net=host \
    --volumes-from SIO-BASE \
    -e PASSWORD="Scaleio123" \
    -e MDM1="ip.ip.ip.ip" \
    -e MDM1_NAME="MDM1" \
    -e MDM2="ip.ip.ip.ip" \
    -e MDM2_NAME="MDM2" \
    -e TB1="ip.ip.ip.ip" \
    -e TB1_NAME="TB1" \
    --name MDM1 \
    victorock/scaleio2:mdm

### START
  docker exec MDM1 sh -x /usr/local/bin/start.sh

### SETUP
  docker exec MDM1 sh -x /usr/local/bin/setup.sh

# Host 2
## MDM2
### RUN
  docker run -d \
    --privileged \
    -P \
    --net=host \
    --name MDM2 \
    victorock/scaleio2:mdm

### START
  docker exec MDM2 /usr/local/bin/start.sh

# Host3
## TB
### RUN
  docker run -d \
    --privileged \
    -P \
    --net=host \
    --name TB1 \
    victorock/scaleio2:tb

### START
  docker exec TB1 /usr/local/bin/start.sh

# Admin Hosts
## Gateway
### RUN
  docker run -d \
    --privileged \
    -P \
    --net=host \
    -e PASSWORD="Scaleio123" \
    -e MDM1="ip.ip.ip.ip" \
    -e MDM2="ip.ip.ip.ip" \
    -e MDM3="ip.ip.ip.ip" \
    --name GW \
    victorock/scaleio2:gateway

### START
  docker exec GW /usr/local/bin/start.sh

# Storage Servers
## SDS
### RUN
  docker run -d \
    --privileged \
    -P \
    --net=host \
    --name SDS \
    victorock/scaleio2:sds

### START
  docker exec SDS /usr/local/bin/start.sh

### SETUP
  docker exec SDS /usr/local/bin/start.sh

# All Hosts
## LIA
### RUN
  docker run -d \
    --privileged \
    -P \
    --net=host \
    -e PASSWORD="Scaleio123" \
    --name LIA \
    victorock/scaleio2:lia

### START
  docker exec LIA /usr/local/bin/start.sh
