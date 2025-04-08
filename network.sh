#!/bin/bash
# (Re)Create and start the $NETWORK_NAME network in libvirt based on the file $NETWORK_FILE
NETWORK_NAME=default
NETWORK_FILE=terraform_network.xml

sudo virsh net-destroy $NETWORK_NAME
sudo cp $NETWORK_FILE /usr/share/libvirt/networks/
sudo virsh net-undefine $NETWORK_NAME
sudo virsh net-define /usr/share/libvirt/networks/$NETWORK_FILE
sudo virsh net-start $NETWORK_NAME
sudo virsh net-autostart $NETWORK_NAME
