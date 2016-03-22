#!/bin/bash

function 3c_step0() {
  echo "Building MDM1.."
  ( node_mdm1 && \
    docker-compose -f config/controller.yml build )&

  echo "Building MDM2.."
  ( node_mdm2 && \
    docker-compose -f config/controller.yml build )&

  echo "Building TB1.."
  ( node_tb1 && \
    docker-compose -f config/controller-tb.yml build )&
}

function 3c_step1() {

  wait_compose_finish
  echo "Starting MDM1.."
  ( node_mdm1 && \
    docker-compose -f config/controller.yml up -d )&

  wait_compose_finish
  echo "Starting MDM2.."
  ( node_mdm2 && \
    docker-compose -f config/controller.yml up -d )&

  echo "Starting TB1.."
  ( node_tb1 && \
    docker-compose -f config/controller-tb.yml up -d )&
}

function 3c_step2() {
  wait_compose_finish
  ( node_mdm1 && lia_exec_start && mdm_exec_start && gw_exec_start )
  wait_docker_finish
  ( node_mdm2 && lia_exec_start && mdm_exec_start && gw_exec_start )
  ( node_tb1  && lia_exec_start && tb_exec_start && gw_exec_start )
}

function 3c_step3() {
  wait_docker_finish
  ( node_mdm1 && lia_exec_setup && mdm_exec_setup && gw_exec_setup )
  wait_docker_finish
  ( node_mdm2 && lia_exec_setup && mdm_exec_setup && gw_exec_setup )
  ( node_tb1  && lia_exec_setup && tb_exec_setup && gw_exec_setup )
}
