#!/bin/bash

# Discover disks
# Send the list of disks to discovery service
fdisk -l | grep Disk | grep sectors | cut -d':' -f1 | cut -d' ' -f2 | egrep '(sd|vd|xd|rb)[a-z]'
