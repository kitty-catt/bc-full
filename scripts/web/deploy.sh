#!/bin/bash

echo "deploy web frontend"

oc new-app --name=web \
   -e AUTH_HOST=auth -e AUTH_PORT=8080 \
   -e CATALOG_HOST=catalog -e CATALOG_PORT=8080 \
   -e CUSTOMER_HOST=customer -e CUSTOMER_PORT=8080 \
   -e ORDERS_HOST=orders -e ORDERS_PORT=8080 \
   --image-stream=web \
   -l app.kubernetes.io/part-of=web-subsystem

oc expose svc/web \
  -l app.kubernetes.io/part-of=web-subsystem
