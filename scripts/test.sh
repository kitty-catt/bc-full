#!/bin/bash

echo "building images"
export HERE=${PWD}
echo "Working from $HERE"

bash $HERE/scripts/catalog/test.sh
bash $HERE/scripts/customers/test.sh
bash $HERE/scripts/inventory/test.sh
bash $HERE/scripts/orders/test.sh
bash $HERE/scripts/web/test.sh