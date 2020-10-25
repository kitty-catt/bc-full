#!/bin/bash

export HERE=${PWD}
echo "Working from $HERE"

source $HERE/config

oc new-project $NAMESPACE

echo "temporary artifacts are stored in: " /tmp/$WORKSPACE
exit

rm -i /tmp/$WORKSPACE
mkdir -pv /tmp/$WORKSPACE

bash setup-pipeline.sh
bash inventory/setup-inventory-ms.sh



