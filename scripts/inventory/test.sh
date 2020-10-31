#!/bin/bash

echo "testing inventory deployment"

export ROUTE=$(oc get route | grep inventory | awk  '{ print $2}')
curl -w "\n" $ROUTE/micro/about