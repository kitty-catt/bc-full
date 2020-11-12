#!/bin/bash
source ~/config

echo "deploy orders"

# --as-deployment-config \
oc new-app \
 --name=orders \
 ${OCNEWAPP_OPTION} \
 --image-stream=orders \
 -e jdbcURL=jdbc:mysql://ordersmysql:3307/${ORDER_DATABASE}?useSSL=true \
 -e dbuser=${ORDER_USER} -e dbpassword=${ORDER_PASSWORD} \
 -e jwksIssuer="https://localhost:9444/oidc/endpoint/OP"
 
oc expose svc/orders