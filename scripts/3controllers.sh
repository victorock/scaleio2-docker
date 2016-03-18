#!/bin/bash

function 3c_step0() {
  node_mdm1
  docker-compose -f config/controller.yaml build

  node_mdm2
  docker-compose -f config/controller.yaml build

  node_tb1
  docker-compose -f config/controller-tb.yaml build

}

function 3c_step1() {
  node_mdm1
  docker-compose -f config/controller.yaml up

  node_mdm2
  docker-compose -f config/controller.yaml up

  node_tb1
  docker-compose -f config/controller-tb.yaml up

}

function 3c_step2() {
  node_mdm1
  mdm_exec

  node_mdm2
  mdm_exec

  node_tb1
  tb_exec
}
