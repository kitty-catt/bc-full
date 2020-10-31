#!/bin/bash

echo "setup customers"

# Start a CouchDB Container with a database user, a password, and create a new database
#docker run --name customercouchdb -p 5985:5984 -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=passw0rd -d couchdb:2.1.2

#Then visit http://127.0.0.1:5985/_utils/#login

# DANGER 1: A root pod from the wild!
# Limit the danger to this deployment.
oc create sa couchdb
oc adm policy add-scc-to-user anyuid -z couchdb

# DANGER 2: an easy to guess login.

oc new-app --name=customercouchdb \
   -e COUCHDB_USER=admin \
   -e COUCHDB_PASSWORD=passw0rd \
   --docker-image=couchdb:2.1.2 \
   --as-deployment-config

oc patch dc/customercouchdb --patch '{"spec":{"template":{"spec":{"serviceAccountName": "couchdb"}}}}'

oc expose svc customercouchdb --port=5984


