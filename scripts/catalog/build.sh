#!/bin/bash

echo "build catalog"

#NOTE: use "oc create for a plr that uses a generated name"
oc create -f $HERE/tekton-pipeline-run/catalog-run-auto.yaml