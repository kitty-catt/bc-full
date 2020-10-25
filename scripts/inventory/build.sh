#!/bin/bash

echo "building inventory image"
#oc apply -f $HERE/tekton-pipeline-run/inventory-run.yaml
oc create -f $HERE/tekton-pipeline-run/inventory-run-auto.yaml

#Note: the inventory-run-auto.yaml will generate a name for the pipelinerun, it MUST use oc create/
