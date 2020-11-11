#!/bin/bash
source ~/config

echo "building images"
export HERE=${PWD}
echo "Working from $HERE"

bash $HERE/scripts/catalog/build.sh
bash $HERE/scripts/customers/build.sh
bash $HERE/scripts/inventory/build.sh
bash $HERE/scripts/orders/build.sh
bash $HERE/scripts/web/build.sh
bash $HERE/scripts/auth/build.sh