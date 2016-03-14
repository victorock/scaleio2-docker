#!/bin/bash

function admin_login(){
  master=$1
  pass=$2
  scli  --login \
        --username admin \
        --password "${pass}" \
        --mdm_ip "${master}" \
        --approve_certificate
}

function admin_password_change(){
  master=$1
  pass=$2
  new_pass=$3
  admin_login "${master}" "${pass}" &&
  scli  --set_password \
        --old_password "${pass}" \
        --new_password "${new_pass}" \
        --mdm_ip "${master}" \
        --approve_certificate
}

function cluster_tb_add(){
    master=$1
    pass=$2
    tb=$3
    tb_name=$4
    admin_login "${master}" "${pass}" && \
    scli  --add_standby_mdm \
          --new_mdm_ip "${tb}" \
          --mdm_role tb \
          --new_mdm_management_ip "${tb}" \
          --new_mdm_name "${tb_name}" \
          --approve_certificate
}

function cluster_mdm_add(){
    master=$1
    pass=$2
    mdm=$3
    mdm_name=$4
    admin_login "${master}" "${pass}" && \
    scli  --add_standby_mdm \
          --new_mdm_ip "${mdm}" \
          --mdm_role manager \
          --new_mdm_management_ip "${mdm}" \
          --new_mdm_name "${mdm_name}" \
          --approve_certificate
}

function init_cluster(){
  master=$1
  pass=$2
  master_name=$3
  scli  --create_mdm_cluster \
         --master_mdm_ip "${master}" \
         --master_mdm_management_ip "${master}" \
         --master_mdm_name "${master_name}" \
         --accept_license \
         --approve_certificate
  sleep 20
  admin_password_change "${master}" "admin" "${pass}"
}

function cluster_mode3(){
  master=$1
  pass=$2
  mdm2=$3
  tb1=$4
  admin_login "${master}" "${pass}" && \
  scli  --mdm_ip "${master}" \
        --switch_cluster_mode \
        --cluster_mode 3_node \
        --add_slave_mdm_ip "${mdm2}" \
        --add_tb_ip "${tb1}" \
        --i_am_sure
}

function cluster_mode5(){
  master=$1
  pass=$2
  mdm2=$3
  mdm3=$4
  tb1=$5
  tb2=$6
  admin_login "${master}" "${pass}" && \
  scli  --mdm_ip "${master}" \
        --switch_cluster_mode \
        --cluster_mode 5_node \
        --add_slave_mdm_ip "${mdm2},${mdm3}" \
        --add_tb_ip "${tb1},${tb2}" \
        --i_am_sure
}

# INIT CLUSTER
init_cluster "${MDM1}" "${PASSWORD}" "${MDM1_NAME}"

# Configure MDM2
test -z "${MDM2}" ||    cluster_mdm_add "${MDM1}" "${PASSWORD}" "${MDM2}" "${MDM2_NAME}"

# Configure MDM3
test -z "${MDM3}" ||    cluster_mdm_add "${MDM1}" "${PASSWORD}" "${MDM3}" "${MDM3_NAME}"

# Configure TB1 and cluster_mode3
test -z "${TB1}"  || (  cluster_tb_add "${MDM1}" "${PASSWORD}" "${TB1}" "${TB1_NAME}" && \
                        cluster_mode3 "${MDM1}" "${PASSWORD}" "${MDM2}" "${TB1}" )

# Configure TB2 and cluster_mode5
test -z "${TB2}"  || (  cluster_tb_add "${MDM1}" "${PASSWORD}" "${TB2}" "${TB2_NAME}" && \
                        cluster_mode5 "${MDM1}" "${PASSWORD}" "${MDM2}" "${MDM3}" "${TB1}" "${TB2}")

## RELOAD services
systemctl enable mdm.service
systemctl restart mdm.service
