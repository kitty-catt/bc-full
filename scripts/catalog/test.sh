#!/bin/bash

echo "testing catalog deployment"

export ROUTE=$(oc get route | grep catalog | grep -v elastic | awk  '{ print $2}')
curl -i  -w "\n" $ROUTE/micro/about

export ROUTE=$(oc get route | grep elastic | awk  '{ print $2}')
curl -i -w "\n" $ROUTE

