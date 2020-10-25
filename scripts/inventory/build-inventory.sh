#!/bin/bash

echo "building inventory image"
oc apply -f $HERE/tekton-pipeline-run/inventory-run.yaml

