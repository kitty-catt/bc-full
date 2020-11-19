#!/bin/bash

echo "deploy web frontend"

export ROUTE=$(oc get route | grep auth-ms-spring | awk  '{ print $2}')

#echo "ROUTE=>$ROUTE<"

cp $HERE/scripts/web/production-input.json \
   $HERE/scripts/web/production.json

sed -i "s/auth-ms-spring:8080/$ROUTE/" $HERE/scripts/web/production.json

oc create cm config \
 --from-file=$HERE/scripts/web/production.json \
 --from-file=$HERE/scripts/web/default.json \
 --from-file=$HERE/scripts/web/checks

rm $HERE/scripts/web/production.json

oc new-app --name=web \
   -e AUTH_HOST=$ROUTE  \
   -e CATALOG_HOST=catalog-ms-spring -e CATALOG_PORT=8080 \
   -e CUSTOMER_HOST=customer-ms-spring -e CUSTOMER_PORT=8080 \
   -e ORDERS_HOST=orders-ms-spring -e ORDERS_PORT=8080 \
   -e PORT=3000 \
   --image-stream=web \
   -l app.kubernetes.io/part-of=web-subsystem

oc set volume deployment/web --add --type=configmap --mount-path=/project/user-app/config/ --configmap-name=config --name=production-config

oc patch svc web -p '{"spec": {"ports": [{"port": 3000,"targetPort": 3000,"name": "node"}],"type": "LoadBalancer"}}'

oc expose svc/web \
  -l app.kubernetes.io/part-of=web-subsystem \
  --port=3000
