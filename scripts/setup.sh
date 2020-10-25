#!/bin/bash

export HERE=${PWD}
echo "Working from $HERE"

source $HERE/scripts/config

oc new-project $NAMESPACE

echo "temporary artifacts are stored in: " /tmp/$WORKSPACE

if [ -d /tmp/$WORKSPACE ] 
then
    echo "Directory /tmp/$WORKSPACE allready exists, cleaning up." 
    rm -rfi /tmp/$WORKSPACE
    mkdir -pv /tmp/$WORKSPACE
    touch /tmp/$WORKSPACE/kijk.txt
else
    echo "Directory /tmp/$WORKSPACE does not exists."
    mkdir -pv /tmp/$WORKSPACE    
fi


bash $HERE/scripts/setup-pipeline.sh
bash $HERE/scripts/inventory/setup-inventory-ms.sh



