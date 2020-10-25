#!/bin/bash

source $HERE/scripts/config
echo "Setting up generic openshift pipeline"

oc apply -f $HERE/tekton-pipelines/pipeline.yaml 
oc apply -f $HERE/tekton-tasks/appsody-build-push.yaml 

oc create sa appsody-sa
oc policy add-role-to-user admin system:serviceaccount:$NAMESPACE:appsody-sa

oc create secret docker-registry quay-cred \
    --docker-server=quay.io \
    --docker-username=${QUAY_USER} \
    --docker-password=${QUAY_PWD} \
    --docker-email=${QUAY_EMAIL}

oc secrets link appsody-sa quay-cred
#oc describe sa appsody-sa

oc secrets link default quay-cred  --for=pull
#oc describe sa default

oc apply -f $HERE/tekton-resources/inventory-resources.yaml