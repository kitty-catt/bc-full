#!/bin/bash

echo "build auth service for OAuth 2.0 authentication"

#NOTE: use "oc create for a plr that uses a generated name"
oc create -f $HERE/tekton-pipeline-run/auth-run-auto.yaml