#!/bin/bash

function 5c_step0(){
  echo "Building MDM3..."
    ( node_mdm3 && \
      docker-compose -f config/controller.yml build )&

  echo "Building TB2..."
    ( node_tb2 && \
      docker-compose -f config/controller-tb.yml build )&
}

function 5c_step1(){

  wait_compose_finish

  echo "Starting MDM3..."
  ( node_mdm3 && \
    docker-compose -f config/controller.yml up -d )&

  echo "Starting TB2..."
  ( node_tb2 && \
    docker-compose -f config/controller-tb.yml up -d )&
}

function 5c_step2(){
  wait_compose_finish
  ( node_mdm3 && mdm_exec_start && gw_exec_start )
  ( node_tb2  && mdm_exec_start && gw_exec_start )

  wait_docker_finish
  ( node_mdm1 && mdm_exec_setup && gw_exec_setup )
  wait_docker_finish
  ( node_mdm2 && mdm_exec_setup && gw_exec_setup )
  ( node_mdm3 && gw_exec_setup )
  ( node_tb2  && gw_exec_setup )
}
