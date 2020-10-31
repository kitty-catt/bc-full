#!/bin/bash

echo "build customer microservice"

#NOTE: use "oc create for a plr that uses a generated name"
oc create -f $HERE/tekton-pipeline-run/customer-run-auto.yaml