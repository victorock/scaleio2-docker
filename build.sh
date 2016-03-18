#!/bin/bash
. config/config.env
. scripts/common.sh
. scripts/3controllers.sh
. scripts/5controllers.sh
. scripts/sds.sh

# Deploy Controller 1 to 3
function c1-c3() {
  3c_step0
}

# Deploy Controller 4 to 5
function c4-c5(){
  5c_step0
}

# Deploy SDS on SERVER
function sds(){
  server="${1:?"SDS SERVER NOT SET"}"
  sds_step1 "${server}"
}

case $1 in
  "3c")
    echo "Building 3-Controllers.."
    c1-c3
    echo "DONE"
  ;;
  "5c")
    echo "Building 5-Controllers.."
    c1-c3
    c4-c5
    echo "DONE"
  ;;
  "sds")
    echo "Building SDS on \"${2}\".."
    sds "${2}"
    echo "DONE"
  ;;
  *)
    echo "Usage $0: 3c|5c [sds <ip>]"
    echo "Example:"
    echo "1) $0 3c"
    echo "2) $0 5c"
    echo "3) $0 sds <ip>"
  ;;
esac
