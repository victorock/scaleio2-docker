#!/bin/bash

function wait_compose_finish() {
  while [ "$(pgrep "docker-compose")" ]; do
    echo "docker-compose running... (waiting)"
    sleep 10
  done
}

function wait_docker_finish() {
  while [ "$(pgrep "docker")" ]; do
    echo "docker running... (waiting)"
    sleep 10
  done
}

function node_mdm1(){
  server="${MDM1:?'$MDM1 not specified in config/config.env'}"
  node_general "${server}"
}

function node_mdm2(){
  server="${MDM2:?'$MDM2 not specified in config/config.env'}"
  node_general "${server}"
}

function node_mdm3(){
  server="${MDM3:?'$MDM3 not specified in config/config.env'}"
  node_general "${server}"
}

function node_tb1(){
  server="${TB1:?'$TB1 not specified in config/config.env'}"
  node_general "${server}"
}

function node_tb2(){
  server="${TB2:?'$TB2 not specified in config/config.env'}"
  node_general "${server}"
}

function node_general(){
  server="${1:?'NODE NOT SPECIFIED'}"
  export DOCKER_HOST="tcp://${server}:2375"
}

function mdm_exec_start(){
  docker exec SIO-MDM /usr/local/scripts/start.sh
}

function mdm_exec_setup(){
  docker exec SIO-MDM /usr/local/scripts/setup.sh
}

function gw_exec_start(){
  docker exec SIO-GW /usr/local/scripts/start.sh
}

function gw_exec_setup(){
  docker exec SIO-GW /usr/local/scripts/setup.sh
}

function sds_exec_start(){
  INSTANCE="${1:-}"
  docker exec SIO-SDS${INSTANCE} /usr/local/scripts/start.sh
}

function sds_exec_setup(){
  INSTANCE="${1:-}"
  docker exec SIO-SDS${INSTANCE} /usr/local/scripts/setup.sh
}
