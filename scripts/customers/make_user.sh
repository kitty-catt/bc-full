#!/bin/bash

echo "testing customers deployment"
source ~/config

# OPEN THE DOOR
oc expose svc customer-ms-spring

sleep 7

# default JWT admin token:
export jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJhZG1pbiJdLCJ1c2VyX25hbWUiOiJmb28ifQ.hZEmuywb637OrP_6AKDiyZ5_mZ1lVJlwzCOG4egLa1c

export ROUTE=$(oc get route | grep customer | grep -v couchdb | awk  '{ print $2}')

# create a customer using the admin token
curl -s -v -X POST -i "http://$ROUTE/micro/customer/add" -H "Content-Type: application/json" -H "Authorization: Bearer ${jwt}" -d "{\"username\": \"${TEST_USER}\", \"password\": \"bar\", \"firstName\": \"foo\", \"lastName\": \"bar\", \"email\": \"foo@bar.com\"}"

# search a customer using the admin token
#curl -s -X GET "http://$ROUTE/micro/customer/search?username=${TEST_USER}" -H 'Content-type: application/json' -H "${jwt}" 
curl -s -v -X GET "http://$ROUTE/micro/customer/search?username=${TEST_USER}" -H 'Content-type: application/json' -H "Authorization: Bearer ${jwt}" | jq .

# CLOSE THE DOOR
oc delete route customer-ms-spring
