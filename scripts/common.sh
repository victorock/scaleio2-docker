#!/bin/bash

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
  export DOCKER_HOST="tcp://${server}:2376"
}

function mdm_exec(){
  docker exec -it SIO-MDM /usr/local/scripts/start.sh
  docker exec -it SIO-MDM /usr/local/scripts/setup.sh
}

function gw_exec(){
  docker exec -it SIO-GW /usr/local/scripts/start.sh
  docker exec -it SIO-GW /usr/local/scripts/setup.sh
}

function tb_exec(){
  ## We keep the name SIO-MDM to avoid running MDM and TB in the same host
  docker exec -it SIO-MDM /usr/local/scripts/start.sh
  #TB doesn't runs setup
}

function sds_exec(){
  INSTANCE="${1:-}"
  docker exec -it SDS"${INSTANCE}" /usr/local/scripts/start.sh
  #TB doesn't runs setup
}
