#!/bin/bash

echo "testing customers deployment"

export ROUTE=$(oc get route | grep customercouchdb | awk  '{ print $2}')
curl -w "\n" $ROUTE

echo "TODO: check customer service"