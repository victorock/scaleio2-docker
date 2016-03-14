
# Containers to run ScaleIO
The configuration of ScaleIO is not embedded in the container.
Puppet is installed inside of the containers.
Please, consider using puppet-scaleio2 if you would like to proceed with automation/configuration.

Installation procedure:

# MDM1 on Host1
docker run -d \
  --privileged \
  -P \
  --net=host \
  -e PASSWORD="Scaleio123" \
  -e MDM1="ip.ip.ip.ip" \
  -e MDM1_NAME="MDM1" \
  -e MDM2="ip.ip.ip.ip" \
  -e MDM2_NAME="MDM2" \
  -e TB1="ip.ip.ip.ip" \
  -e TB1_NAME="TB1" \
  --name MDM1 \
  victorock/scaleio2:mdm

  # Start
  docker exec MDM1 sh -x /usr/local/bin/start.sh

  # Setup
  docker exec MDM1 sh -x /usr/local/bin/setup.sh

# MDM2 on Host2
docker run -d \
  --privileged \
  -P \
  --net=host \
  --name MDM2 \
  victorock/scaleio2:mdm

  # Start
  docker exec MDM2 /usr/local/bin/start.sh

# TB on Host3
docker run -d \
  --privileged \
  -P \
  --net=host \
  --name TB1 \
  victorock/scaleio2:tb

  # Start
  docker exec TB1 /usr/local/bin/start.sh
