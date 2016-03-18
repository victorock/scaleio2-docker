
# Description

The idea behind the creation of this repository is to have ScaleIO modules easily
installed and integrated on OpenStack deployments that adopt containers.

The content of this repository implements ScaleIO Version 2.0, and tested with base OS that supports systemd: (CentOS 7.2 - Atomic).

All the ScaleIO RPM packages are available for download from EMC Website <https://www.emc.com/getscaleio>.
In order to facilitate the deployment/redeployment/build of ScaleIO containers, the packages therefore mentioned were copied to the repository: <https://dl.bintray.com/victorock/scaleio/centos/$releasever/x86_64/> (Refer: sio-base/config/bintray-victorock-scaleio).

*Disclaimer: This content doesn't gives you any rights/official support from EMC.
So use it with caution.*

# Requirements
The server were the containers will be deployed need to have at least 3GB of Memory.

*It is due the Java requirements to run ScaleIO Gateway.*


# Architecture

* Containers:
- sio-base: Contains the basic deps for ScaleIO and stores all configuration data.
- sio-mdm: Run the MDM service and stores all configuration data in <sio-base>.
- sio-sds: Run the SDS service and stores all configuration data in <sio-base>.
- sio-gateway: Run the ScaleIO Webservice and stores all configuration data in <sio-base>.

*Puppet is installed inside of all containers.*

* Docker-Compose:
- config/controller.yaml: Node with sio-base + sio-mdm + sio-gateway
- config/controller-tb.yaml: Node with sio-base + sio-mdm as TB + sio-gateway
- config/sds.yaml: Node with sio-base + sio-sds
- config/sds1.yaml: Node with sio-base + sio-sds1 (instance 1)
- config/sds2.yaml: Node with sio-base + sio-sds1 (instance 2)
- config/sds3.yaml: Node with sio-base + sio-sds1 (instance 3)
- config/sds4.yaml: Node with sio-base + sio-sds1 (instance 4)

# Config

* Edit: config/config.env

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

# Build

- The content of this repository is auto-build: <https://hub.docker.com/r/victorock/scaleio2>

* Auto

```
Usage ./build.sh: 3c|5c [sds <ip>]
Example:
1) ./build.sh 3c
2) ./build.sh 5c
3) ./build.sh sds <ip>
```

* Manual

```
DOCKER_HOST="tcp://IP_HOST1:2376" docker-compose -f config/controller.yaml build
DOCKER_HOST="tcp://IP_HOST2:2376" docker-compose -f config/controller.yaml build
DOCKER_HOST="tcp://IP_HOST3:2376" docker-compose -f config/controller-tb.yaml build
DOCKER_HOST="tcp://IP_HOST4:2376" docker-compose -f config/controller.yaml build
DOCKER_HOST="tcp://IP_HOST5:2376" docker-compose -f config/controller-tb.yaml build

DOCKER_HOST="tcp://IP_HOST6:2376" docker-compose -f config/sds.yaml build
DOCKER_HOST="tcp://IP_HOST7:2376" docker-compose -f config/sds.yaml build
DOCKER_HOST="tcp://IP_HOST8:2376" docker-compose -f config/sds.yaml build
```

# Run

- Run the script and let it go...

* Auto

```
Usage ./run.sh: 3c|5c [sds <ip>]
Example:
1) ./run.sh 3c
2) ./run.sh 5c
3) After Controller deployment:
   ./run.sh sds 10.10.10.10
```

* Manual

```
DOCKER_HOST="tcp://IP_HOST1:2376" docker-compose -f config/controller.yaml up -d
DOCKER_HOST="tcp://IP_HOST2:2376" docker-compose -f config/controller.yaml up -d
DOCKER_HOST="tcp://IP_HOST3:2376" docker-compose -f config/controller-tb.yaml up -d
DOCKER_HOST="tcp://IP_HOST4:2376" docker-compose -f config/controller.yaml up -d
DOCKER_HOST="tcp://IP_HOST5:2376" docker-compose -f config/controller-tb.yaml up -d

DOCKER_HOST="tcp://IP_HOST6:2376" docker-compose -f config/sds.yaml up -d
DOCKER_HOST="tcp://IP_HOST7:2376" docker-compose -f config/sds.yaml up -d
DOCKER_HOST="tcp://IP_HOST8:2376" docker-compose -f config/sds.yaml up -d
```

# Destroy

- Why? But just in case...

* Manual

- stop

```
DOCKER_HOST="tcp://IP_HOST1:2376" docker-compose -f config/controller.yaml stop
DOCKER_HOST="tcp://IP_HOST2:2376" docker-compose -f config/controller.yaml stop
DOCKER_HOST="tcp://IP_HOST3:2376" docker-compose -f config/controller-tb.yaml stop
DOCKER_HOST="tcp://IP_HOST4:2376" docker-compose -f config/controller.yaml stop
DOCKER_HOST="tcp://IP_HOST5:2376" docker-compose -f config/controller-tb.yaml stop

DOCKER_HOST="tcp://IP_HOST6:2376" docker-compose -f config/sds.yaml stop
DOCKER_HOST="tcp://IP_HOST7:2376" docker-compose -f config/sds.yaml stop
DOCKER_HOST="tcp://IP_HOST8:2376" docker-compose -f config/sds.yaml stop
```

- remove

*ATTENTION:This command removes VOLUMES (DATA).*

```
DOCKER_HOST="tcp://IP_HOST1:2376" docker-compose -f config/controller.yaml rm -fv
DOCKER_HOST="tcp://IP_HOST2:2376" docker-compose -f config/controller.yaml rm -fv
DOCKER_HOST="tcp://IP_HOST3:2376" docker-compose -f config/controller-tb.yaml rm -fv
DOCKER_HOST="tcp://IP_HOST4:2376" docker-compose -f config/controller.yaml rm -fv
DOCKER_HOST="tcp://IP_HOST5:2376" docker-compose -f config/controller-tb.yaml rm -fv

DOCKER_HOST="tcp://IP_HOST6:2376" docker-compose -f config/sds.yaml rm -fv
DOCKER_HOST="tcp://IP_HOST7:2376" docker-compose -f config/sds.yaml rm -fv
DOCKER_HOST="tcp://IP_HOST8:2376" docker-compose -f config/sds.yaml rm -fv
```

# TODO

- TLS
- DOCKER-SWARM
  - CREATE PODs (NX-<SERVICE>)
- destroy.sh
- upgrade/update description of commands

# Licensing

Licensed under the Apache License, Version 2.0 (the “License”); you may not use this file except in compliance with the License. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

# Support

Please file bugs and issues at the Github issues page. For more general discussions you can contact the EMC Code team at <a href="https://groups.google.com/forum/#!forum/emccode-users">Google Groups</a>. The code and documentation are released with no warranties or SLAs and are intended to be supported through a community driven process.
