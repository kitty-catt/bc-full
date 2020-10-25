#!/bin/bash

source config
echo "setting up generic openshift pipeline"

oc apply -f ../tekton-pipelines/pipeline.yaml 
oc apply -f ../tekton-tasks/appsody-build-push.yaml 


