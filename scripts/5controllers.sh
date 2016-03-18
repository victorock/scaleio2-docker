#!/bin/bash

function 5c_step0(){
  node_mdm3
  docker-compose -f config/controller.yaml build

  node_tb2
  docker-compose -f config/controller-tb.yaml build

}

function 5c_step1(){
  node_mdm3
  docker-compose -f config/controller.yaml up

  node_tb2
  docker-compose -f config/controller-tb.yaml up

}

function 5c_step2(){
  node_mdm3
  mdm_exec

  node_tb2
  tb_exec
}
