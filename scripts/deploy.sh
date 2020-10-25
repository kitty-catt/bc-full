#!/bin/bash

echo "deploying microservices"
export HERE=${PWD}
echo "Working from $HERE"

bash $HERE/scripts/inventory/deploy-inventory.sh
