#!/bin/bash

echo "testing customers deployment"

export ROUTE=$(oc get route | grep customercouchdb | awk  '{ print $2}')
curl -w "\n" $ROUTE

echo "login manually on http://$ROUTE/_utils/#login "

echo "TODO: check customer service"