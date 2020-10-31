#!/bin/bash

export HERE=${PWD}
echo "Working from $HERE"

source ~/config

oc new-project $NAMESPACE

echo "temporary artifacts are stored in: " /tmp/$WORKSPACE

if [ -d /tmp/$WORKSPACE ] 
then
    echo "Directory /tmp/$WORKSPACE allready exists, cleaning up." 
    rm -rfi /tmp/$WORKSPACE
    mkdir -pv /tmp/$WORKSPACE
else
    echo "Directory /tmp/$WORKSPACE does not exists."
    mkdir -pv /tmp/$WORKSPACE    
fi

bash $HERE/scripts/pipeline/setup.sh

bash $HERE/scripts/catalog/setup.sh
bash $HERE/scripts/customers/setup.sh
bash $HERE/scripts/inventory/setup.sh
bash $HERE/scripts/orders/setup.sh
bash $HERE/scripts/web/setup.sh



