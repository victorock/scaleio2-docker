
# Description

The idea behind the creation of this repository is to easily install/update/upgrade ScaleIO.

Follow some scenarios of deployment:
- OpenStack Controllers
- Storage Nodes
- Bare-metal Containers
- Test/Dev
- Cloud/Virtualized Infrastructure

The content of this repository implements ScaleIO Version 2.0 and requires systemd.

Tests were performed on CentOS 7.2 (Atomic).

All the ScaleIO RPM packages are available for download from EMC Website <https://www.emc.com/getscaleio>.

ScaleIO RPM packages were published in the repository: <https://dl.bintray.com/victorock/scaleio/centos/$releasever/x86_64/> (See: base/config/bintray-victorock-scaleio).

*Disclaimer: This content doesn't gives you any rights/official support from EMC.
Use with caution.*

## Requirements

- Docker connectivity to the Host/Node/Scheduler.

- The server where the Gateway container is deployed requires at least 3GB of Memory (Java Requirement).

- The O.S where containers run must support systemd.

- Containers must run in privileged mode (systemd).

*SDC and XCACHE requires kernel-level interaction, so it must reside directly at the Host.*
*Consider installing LIA to manage SDC/XCACHE updates/upgrades*
*You can easily do it through the Gateway portal, automation (ansible/puppet) or O.S image*

## Architecture

Systemd is used inside of containers to start/stop ScaleIO services.

*There is no other service started by systemd*

### Content and Scripting:

- Call /usr/local/scripts/start.sh to trigger installation of specific packages.

- Call /usr/local/scripts/setup.sh to trigger configuration.

- Puppet is installed inside of all containers.

- Host:/etc/puppet is mounted in base:/etc/puppet and exported to ScaleIO container:/etc/puppet.

- You change the configuration to link the base:/etc/puppet with your puppet container.

- Future: File /usr/local/scripts/setup.sh triggers puppet to proceed with container configuration.

- Future: Puppet module for scaleio2 is under development in <http://www.github.com/victorock/puppet-scaleio2>

### Containers:

- victorock/scaleio2:base     = Deps and Volumes (Datastore) for ScaleIO containers.

- victorock/scaleio2:mdm      = Run the MDM service.

- victorock/scaleio2:tb       = Run the MDM service as TB.

- victorock/scaleio2:sds      = Run the SDS service.

- victorock/scaleio2:sds1     = Run the SDS1 service.

- victorock/scaleio2:sds2     = Run the SDS2 service.

- victorock/scaleio2:sds3     = Run the SDS3 service.

- victorock/scaleio2:sds4     = Run the SDS4 service.

- victorock/scaleio2:lia      = Run the LIA service (controller).

- victorock/scaleio2:gateway  = Run the ScaleIO Webservice.

### Docker-Compose:

- config/controller.yml: Node with base + lia + mdm + gateway

- config/controller-tb.yml: Node with base + lia + tb + gateway

- config/storage.yml: Node with base + sds

### Docker-Compose (SWARM):

- config/docker-composer.yml: Services to launch ScaleIO containers in docker-swarm.

*Read the config/docker-composer.yml*

### Modules

- config/base.yml: ScaleIO configuration datastore

- config/mdm.yml: Node with base + mdm

- config/tb.yml: Node with base + mdm (TB)

- config/gateway.yml: Node with base + gateway

- config/sds.yml: Node with base + sds (default)

- config/sds1.yml: Node with base + sds1 (instance 1)

- config/sds2.yml: Node with base + sds1 (instance 2)

- config/sds3.yml: Node with base + sds1 (instance 3)

- config/sds4.yml: Node with base + sds1 (instance 4)

## Config

### Edit config/config.env

```
# ScaleIO Password
PASSWORD=Scaleio123

# MDM1
MDM1=192.168.69.137
MDM1_NAME=MDM1

# MDM2
MDM2=192.168.69.138
MDM2_NAME=MDM2

# MDM3
MDM3=
MDM3_NAME=

#TB1
TB1=192.168.69.139
TB1_NAME=TB1

# TB2
TB2=
TB2_NAME=
```

### Docker-swarm: Edit config/docker-compose.yml

*NOT TESTED*

```
## This file deploy all the services required to run ScaleIO
## Use it to deploy ScaleIO Management Services and Storage nodes in docker-swarm
version: '2'
services:
  mdm1:
    extends:
      file: mdm.yml
      service: mdm
## Replace node1 by the corresponding one containing the ip of MDM1
    environment:
      - "constraint:node==node1"

  mdm2:
    extends:
      file: mdm.yml
      service: mdm
    environment:
## Replace node2 by the corresponding one containing the ip of MDM2
      - "constraint:node==node2"

  mdm3:
    extends:
      file: mdm.yml
      service: mdm
    environment:
## Replace node3 by the corresponding one containing the ip of MDM3
      - "constraint:node==node3"

  tb1:
    extends:
      file: tb.yml
      service: tb
    environment:
## Replace node4 by the corresponding one containing the ip of TB1
      - "constraint:node==node4"

  tb2:
    extends:
      file: tb.yml
      service: tb
    environment:
## Replace node5 by the corresponding one containing the ip of TB2
      - "constraint:node==node5"

  gw1:
    extends:
      file: gateway.yml
      service: gateway

  gw2:
    extends:
      file: gateway.yml
      service: gateway

  gw3:
    extends:
      file: gateway.yml
      service: gateway

  storage1:
    extends:
      file: sds.yml
      service: sds
## Comment the fragment below in a case where you want to run Controller
## containers and storage container in the same nodes
    environment:
      - "constraint:image!=~scaleio2:mdm*"
      - "constraint:image!=~scaleio2:tb*"
      - "constraint:image!=~scaleio2:gateway*"
##

  storage2:
    extends:
      file: sds.yml
      service: sds
## Comment the fragment below in a case where you want to run Controller
## containers and storage container in the same nodes
    environment:
      - "constraint:image!=~scaleio2:mdm*"
      - "constraint:image!=~scaleio2:tb*"
      - "constraint:image!=~scaleio2:gateway*"
##

  storage3:
    extends:
      file: sds.yml
      service: sds
## Comment the fragment below in a case where you want to run Controller
## containers and storage container in the same nodes
    environment:
      - "constraint:image!=~scaleio2:mdm*"
      - "constraint:image!=~scaleio2:tb*"
      - "constraint:image!=~scaleio2:gateway*"
##

```

*SWARM Has not filter based on IP and there is no discovery service for ScaleIO:
- We need to define the service where the scaleio will run (SEE <#TODO>)*

## Build

The content of this repository is auto-build: <https://hub.docker.com/r/victorock/scaleio2>

### Auto

```
Usage ./build.sh: 3c|5c [sds <ip>]
Example:
1) ./build.sh 3c
2) ./build.sh 5c
3) ./build.sh sds <ip>
```

### Manual

```
DOCKER_HOST="tcp://IP_HOST1:2375" docker-compose -f config/controller.yml build
DOCKER_HOST="tcp://IP_HOST2:2375" docker-compose -f config/controller.yml build
DOCKER_HOST="tcp://IP_HOST3:2375" docker-compose -f config/controller-tb.yml build
DOCKER_HOST="tcp://IP_HOST4:2375" docker-compose -f config/controller.yml build
DOCKER_HOST="tcp://IP_HOST5:2375" docker-compose -f config/controller-tb.yml build

DOCKER_HOST="tcp://IP_HOST6:2375" docker-compose -f config/sds.yml build
DOCKER_HOST="tcp://IP_HOST7:2375" docker-compose -f config/sds.yml build
DOCKER_HOST="tcp://IP_HOST8:2375" docker-compose -f config/sds.yml build
```

## Run

Run the script and let it go...

### Docker Swarm

*NOT TESTED*

```
<docker swarm commands>
docker-compose -f config/docker-compose.yml up -d
docker-compose -f config/docker-compose.yml exec /usr/local/scripts/start.sh
docker-compose -f config/docker-compose.yml exec /usr/local/scripts/setup.sh
```

### Script

```
Usage ./run.sh: 3c|5c [sds <ip>]
Example:
1) ./run.sh 3c
2) ./run.sh 5c
3) After Controller deployment:
   ./run.sh sds 10.10.10.10
```

### Manual

```
DOCKER_HOST="tcp://IP_HOST1:2375" docker-compose -f config/controller.yml up -d
DOCKER_HOST="tcp://IP_HOST2:2375" docker-compose -f config/controller.yml up -d
DOCKER_HOST="tcp://IP_HOST3:2375" docker-compose -f config/controller-tb.yml up -d
DOCKER_HOST="tcp://IP_HOST4:2375" docker-compose -f config/controller.yml up -d
DOCKER_HOST="tcp://IP_HOST5:2375" docker-compose -f config/controller-tb.yml up -d

DOCKER_HOST="tcp://IP_HOST6:2375" docker-compose -f config/sds.yml up -d
DOCKER_HOST="tcp://IP_HOST7:2375" docker-compose -f config/sds.yml up -d
DOCKER_HOST="tcp://IP_HOST8:2375" docker-compose -f config/sds.yml up -d

### Run Install script inside the container
DOCKER_HOST="tcp://IP_HOST1:2375" docker exec LIA /usr/local/scripts/start.sh
DOCKER_HOST="tcp://IP_HOST1:2375" docker exec MDM /usr/local/scripts/start.sh
DOCKER_HOST="tcp://IP_HOST1:2375" docker exec GW /usr/local/scripts/start.sh

DOCKER_HOST="tcp://IP_HOST2:2375" docker exec LIA /usr/local/scripts/start.sh
DOCKER_HOST="tcp://IP_HOST2:2375" docker exec MDM /usr/local/scripts/start.sh
DOCKER_HOST="tcp://IP_HOST2:2375" docker exec GW /usr/local/scripts/start.sh

DOCKER_HOST="tcp://IP_HOST3:2375" docker exec LIA /usr/local/scripts/start.sh
DOCKER_HOST="tcp://IP_HOST3:2375" docker exec MDM /usr/local/scripts/start.sh
DOCKER_HOST="tcp://IP_HOST3:2375" docker exec GW /usr/local/scripts/start.sh

DOCKER_HOST="tcp://IP_HOST4:2375" docker exec LIA /usr/local/scripts/start.sh
DOCKER_HOST="tcp://IP_HOST4:2375" docker exec MDM /usr/local/scripts/start.sh
DOCKER_HOST="tcp://IP_HOST4:2375" docker exec GW /usr/local/scripts/start.sh

DOCKER_HOST="tcp://IP_HOST5:2375" docker exec LIA /usr/local/scripts/start.sh
DOCKER_HOST="tcp://IP_HOST5:2375" docker exec MDM /usr/local/scripts/start.sh
DOCKER_HOST="tcp://IP_HOST5:2375" docker exec GW /usr/local/scripts/start.sh

### Run Setup script inside the container
DOCKER_HOST="tcp://IP_HOST1:2375" docker exec LIA /usr/local/scripts/setup.sh
DOCKER_HOST="tcp://IP_HOST1:2375" docker exec MDM /usr/local/scripts/setup.sh
DOCKER_HOST="tcp://IP_HOST1:2375" docker exec GW /usr/local/scripts/setup.sh

DOCKER_HOST="tcp://IP_HOST2:2375" docker exec LIA /usr/local/scripts/setup.sh
DOCKER_HOST="tcp://IP_HOST2:2375" docker exec MDM /usr/local/scripts/setup.sh
DOCKER_HOST="tcp://IP_HOST2:2375" docker exec GW /usr/local/scripts/setup.sh

DOCKER_HOST="tcp://IP_HOST3:2375" docker exec LIA /usr/local/scripts/setup.sh
DOCKER_HOST="tcp://IP_HOST3:2375" docker exec MDM /usr/local/scripts/setup.sh
DOCKER_HOST="tcp://IP_HOST3:2375" docker exec GW  /usr/local/scripts/setup.sh

DOCKER_HOST="tcp://IP_HOST4:2375" docker exec LIA /usr/local/scripts/setup.sh
DOCKER_HOST="tcp://IP_HOST4:2375" docker exec MDM /usr/local/scripts/setup.sh
DOCKER_HOST="tcp://IP_HOST4:2375" docker exec GW /usr/local/scripts/setup.sh

DOCKER_HOST="tcp://IP_HOST5:2375" docker exec LIA /usr/local/scripts/setup.sh
DOCKER_HOST="tcp://IP_HOST5:2375" docker exec MDM /usr/local/scripts/setup.sh
DOCKER_HOST="tcp://IP_HOST5:2375" docker exec GW /usr/local/scripts/setup.sh

DOCKER_HOST="tcp://IP_HOST6:2375" docker exec SDS /usr/local/scripts/start.sh

DOCKER_HOST="tcp://IP_HOST7:2375" docker exec SDS /usr/local/scripts/start.sh

DOCKER_HOST="tcp://IP_HOST8:2375" docker exec SDS /usr/local/scripts/start.sh
```

## Update

You just need to run (compose) and the build will trigger update if there are new container images.


## Backup

You just need to save the BASE container.

## Destroy

Why?

### Docker Swarm

*ATTENTION: All ScaleIO containers are destroyed, so all configuration will be lost!!*

```
<docker swarm commands>
docker-compose -f config/docker-compose.yml stop
docker-compose -f config/docker-compose.yml rm -fv
```

### Manual

- Stop

```
DOCKER_HOST="tcp://IP_HOST1:2375" docker-compose -f config/controller.yml stop
DOCKER_HOST="tcp://IP_HOST2:2375" docker-compose -f config/controller.yml stop
DOCKER_HOST="tcp://IP_HOST3:2375" docker-compose -f config/controller-tb.yml stop
DOCKER_HOST="tcp://IP_HOST4:2375" docker-compose -f config/controller.yml stop
DOCKER_HOST="tcp://IP_HOST5:2375" docker-compose -f config/controller-tb.yml stop

DOCKER_HOST="tcp://IP_HOST6:2375" docker-compose -f config/sds.yml stop
DOCKER_HOST="tcp://IP_HOST7:2375" docker-compose -f config/sds.yml stop
DOCKER_HOST="tcp://IP_HOST8:2375" docker-compose -f config/sds.yml stop
```

- Remove

*ATTENTION:This command removes VOLUMES (DATA).*

```
DOCKER_HOST="tcp://IP_HOST1:2375" docker-compose -f config/controller.yml rm -fv
DOCKER_HOST="tcp://IP_HOST2:2375" docker-compose -f config/controller.yml rm -fv
DOCKER_HOST="tcp://IP_HOST3:2375" docker-compose -f config/controller-tb.yml rm -fv
DOCKER_HOST="tcp://IP_HOST4:2375" docker-compose -f config/controller.yml rm -fv
DOCKER_HOST="tcp://IP_HOST5:2375" docker-compose -f config/controller-tb.yml rm -fv

DOCKER_HOST="tcp://IP_HOST6:2375" docker-compose -f config/sds.yml rm -fv
DOCKER_HOST="tcp://IP_HOST7:2375" docker-compose -f config/sds.yml rm -fv
DOCKER_HOST="tcp://IP_HOST8:2375" docker-compose -f config/sds.yml rm -fv
```

# TODO

- ScaleIO Discovery Service
- Test upgrade/update
- Test with Swarm

# Tips

## Docker Configuration to listen for TCP connections

```
# /etc/sysconfig/docker
OPTIONS='--selinux-enabled -H tcp://0.0.0.0:2375'
```

## Docker Storage configuration to disable deferred_removal and deferred_deletion

```
# /etc/sysconfig/docker-storage
DOCKER_STORAGE_OPTIONS=--storage-driver devicemapper --storage-opt dm.fs=xfs --storage-opt dm.thinpooldev=/dev/mapper/cah-docker--pool --storage-opt dm.use_deferred_removal=false --storage-opt dm.use_deferred_deletion=false
```

## Install Docker Swarm

*Doc: https://docs.docker.com/swarm/install-w-machine/*

- Create Master node

```
docker-machine create --driver vmwarefusion swarm
docker-machine env swarm
eval $(docker-machine env swarm)
docker-machine ls
docker run --rm swarm create

docker run -d -p 3376:3376 \
            -t \
            swarm manage \
              -H 0.0.0.0:3376 \
              token://<cluster_token>
```

- Add slave nodes

```
DOCKER_HOST="tcp://IP_HOST1:2375" docker run -d swarm join \
  --addr=<ip_master>:2375 token://<cluster_token>

DOCKER_HOST="tcp://IP_HOST2:2375" docker run -d swarm join \
  --addr=<ip_master>:2375 token://<cluster_token>

DOCKER_HOST="tcp://IP_HOST3:2375" docker run -d swarm join \
  --addr=<ip_master>:2375 token://<cluster_token>
```

- Run ScaleIO in Swarm

```
export DOCKER_HOST=$(docker-machine ip swarm):3376
docker-compose -f config/docker-compose.yml up -d
docker-compose -f config/docker-compose.yml exec /usr/local/scripts/start.sh
docker-compose -f config/docker-compose.yml exec /usr/local/scripts/setup.sh
```

# Licensing

Licensed under the Apache License, Version 2.0 (the “License”); you may not use this file except in compliance with the License. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

# Support

Please file bugs and issues at the Github issues page. For more general discussions you can contact the EMC Code team at <a href="https://groups.google.com/forum/#!forum/emccode-users">Google Groups</a>. The code and documentation are released with no warranties or SLAs and are intended to be supported through a community driven process.
