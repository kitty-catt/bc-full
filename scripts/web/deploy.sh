#!/bin/bash

echo "deploy web frontend"

oc new-app --name=web \
   -e AUTH_HOST=auth-ms-spring -e AUTH_PORT=8080 \
   -e CATALOG_HOST=catalog-ms-spring -e CATALOG_PORT=8080 \
   -e CUSTOMER_HOST=customer-ms-spring -e CUSTOMER_PORT=8080 \
   -e ORDERS_HOST=orders-ms-spring -e ORDERS_PORT=8080 \
   -e PORT=3000 \
   --image-stream=web \
   -l app.kubernetes.io/part-of=web-subsystem

oc patch svc web -p '{"spec": {"ports": [{"port": 3000,"targetPort": 3000,"name": "node"}],"type": "LoadBalancer"}}'

oc expose svc/web \
  -l app.kubernetes.io/part-of=web-subsystem \
  --port=3000
