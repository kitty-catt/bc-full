#!/bin/bash

echo "testing customers deployment"

export ROUTE=$(oc get route | grep customercouchdb | awk  '{ print $2}')
curl -w "\n" $ROUTE

echo "login manually on http://$ROUTE/_utils/#login "

echo "TODO: check customer service"

# default JWT admin token:
#eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJhZG1pbiJdLCJ1c2VyX25hbWUiOiJmb28ifQ.hZEmuywb637OrP_6AKDiyZ5_mZ1lVJlwzCOG4egLa1c

# default JWT blue token:
#eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJibHVlIl0sInVzZXJfbmFtZSI6IiJ9.PGVxVMaxtAL2kh5ik1H6tcKLDv0xeh7klrJvrxEny48