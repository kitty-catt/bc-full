#!/bin/bash

echo "deploying microservices"
export HERE=${PWD}
echo "Working from $HERE"

bash $HERE/scripts/catalog/deploy.sh
bash $HERE/scripts/customers/deploy.sh
bash $HERE/scripts/inventory/deploy.sh
bash $HERE/scripts/orders/deploy.sh
bash $HERE/scripts/web/deploy.sh
bash $HERE/scripts/auth/deploy.sh