#!/bin/bash

echo "deploy auth service for OAuth 2.0 authentication"

oc new-app --name=auth \
 -e HS256_KEY=${HS256_KEY} \
  --image-stream=auth 

oc expose svc/auth --port=8080