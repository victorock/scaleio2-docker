#!/bin/bash

function sds_step0(){
  echo "Building SDS.."
  ( node_general "${1}" && \
    docker-compose -f config/storage.yml build )
}

function sds_step1(){
  ( node_general "${1}" && \
    docker-compose -f config/storage.yml up -d )&
}

function sds_step2(){
  wait_compose_finish
  ( node_general "${1}" && sds_exec_start )
}

function sds_step3(){
  wait_compose_finish
  ( node_general "${1}" && sds_exec_setup )
}
