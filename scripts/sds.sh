#!/bin/bash

function sds_step0(){
  node_general "${1}"
  docker-compose -f config/sds.yaml build
}

function sds_step1(){
  node_general "${1}"
  docker-compose -f config/sds.yaml up
}

function sds_step2(){
  node_general "${1}"
  sds_exec
}
