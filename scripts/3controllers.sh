#!/bin/bash

function 3c_step0() {
  echo "Building MDM1.."
  ( node_mdm1 && \
    docker-compose -f config/controller.yaml build )&

  echo "Building MDM2.."
  ( node_mdm2 && \
    docker-compose -f config/controller.yaml build )&

  echo "Building TB1.."
  ( node_tb1 && \
    docker-compose -f config/controller-tb.yaml build )&
}

function 3c_step1() {

  wait_compose_finish

  echo "Starting MDM1.."
  ( node_mdm1 && \
    docker-compose -f config/controller.yaml up -d )&

  echo "Starting MDM2.."
  ( node_mdm2 && \
    docker-compose -f config/controller.yaml up -d )&

  echo "Starting TB1.."
  ( node_tb1 && \
    docker-compose -f config/controller-tb.yaml up -d )&
}

function 3c_step2() {

  wait_compose_finish
  ( node_mdm1 && mdm_exec_start && gw_exec_start )
  ( node_mdm2 && mdm_exec_start && gw_exec_start )
  ( node_tb1  && mdm_exec_start && gw_exec_start )

  wait_docker_finish
  ( node_mdm1 && mdm_exec_setup && gw_exec_setup )
  ( node_mdm2 && gw_exec_setup )
  ( node_tb1  && gw_exec_setup )


}
