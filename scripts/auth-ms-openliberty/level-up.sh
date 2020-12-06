#!/bin/bash

source ~/config
HERE=$(pwd)

echo "*** GENERATING THE COVETED KEYS *** "
rm -Rf /tmp/$NAMESPACE
mkdir -pv /tmp/$NAMESPACE
cd /tmp/$NAMESPACE
keytool -genkeypair -dname "cn=bc.ibm.com, o=User, ou=IBM, c=US" -alias bckey -keyalg RSA -keysize 2048 -keypass password -storetype PKCS12 -keystore ./BCKeyStoreFile.p12 -storepass password -validity 3650
keytool -list -keystore ./BCKeyStoreFile.p12 -storepass password
keytool -export -alias bckey -file client.cer -keystore ./BCKeyStoreFile.p12 -storepass password
keytool -import -v -trustcacerts -alias bckey -file client.cer -keystore ./truststore.p12 -storepass password -noprompt

echo "*** BUILDING IMAGE *** "

oc apply -f tekton-resources/auth-resources-liberty.yaml
oc create -f tekton-pipeline-run/auth-run-auto.yaml

echo "*** REMOVING OLD MICROSERVICES *** "

oc delete route auth-ms-spring
oc delete svc auth-ms-spring
oc delete deployment auth-ms-spring

oc delete svc customer-ms-spring
oc delete deployment customer-ms-spring

oc new-app --name=auth-ms-openliberty \
  --image-stream=auth-ms-openliberty \
  -l app.kubernetes.io/part-of=auth-subsystem

echo "*** MOUNTING THE KEYSTORE *** "
# /opt/ol/wlp/usr/servers/defaultServer/resources/security/BCKeyStoreFile.p12

oc delete secret bc-keys 2>/dev/null

oc create secret generic bc-keys \
 --from-file=/tmp/$NAMESPACE/BCKeyStoreFile.p12

oc set volume deployment/auth-ms-openliberty --add --type=secret --mount-path=/opt/ol/wlp/usr/servers/defaultServer/resources/security/ --secret-name=bc-keys --name=bc-keys

echo "*** DELETING THE KEYS *** "
rm -Rf /tmp/$NAMESPACE

oc expose svc/auth-ms-openliberty --port=9443 \
  -l app.kubernetes.io/part-of=auth-subsystem

cd -
