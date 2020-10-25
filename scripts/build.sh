#!/bin/bash

echo "building images"
export HERE=${PWD}
echo "Working from $HERE"

bash $HERE/scripts/inventory/build-inventory.sh