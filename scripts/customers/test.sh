#!/bin/bash

echo "testing customers deployment"
source ~/config

#export ROUTE=$(oc get route | grep customercouchdb | awk  '{ print $2}')
#curl -w "\n" $ROUTE
#echo "login manually on http://$ROUTE/_utils/#login "

echo "check customer service"

# default JWT admin token:
export jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJhZG1pbiJdLCJ1c2VyX25hbWUiOiJmb28ifQ.hZEmuywb637OrP_6AKDiyZ5_mZ1lVJlwzCOG4egLa1c

# default JWT blue token:
export jwt_blue=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJibHVlIl0sInVzZXJfbmFtZSI6IiJ9.PGVxVMaxtAL2kh5ik1H6tcKLDv0xeh7klrJvrxEny48

export ROUTE=$(oc get route | grep customer | grep -v couchdb | awk  '{ print $2}')

# create a customer using the admin token
set -x
curl -X POST -i "http://$ROUTE/micro/customer/add" -H "Content-Type: application/json" -H "Authorization: Bearer ${jwt}" -d "{\"username\": \"${TEST_USER}\", \"password\": \"bar\", \"firstName\": \"foo\", \"lastName\": \"bar\", \"email\": \"foo@bar.com\"}"

# search a customer using the admin token
#curl -s -X GET "http://$ROUTE/micro/customer/search?username=${TEST_USER}" -H 'Content-type: application/json' -H "${jwt}" 
curl -s -X GET "http://$ROUTE/micro/customer/search?username=${TEST_USER}" -H 'Content-type: application/json' -H "Authorization: Bearer ${jwt}" | jq .


# precious hint: ... port 8082
# 2020-10-31 10:19:17.045  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8082 (http) with context path '/micro'

