# 1 Purpose

This repository aims to deploy the full IBM Blue Compute shop with a single command into an Openshift Cluster with corresponding Tekton pipeline. The Tekton pipeline will build the repo's from source to container image. <br>

The following repositories are deployed: <br>

[IBM blue compute](https://github.com/ibm-garage-ref-storefront/?q=storefront-ui+OR+spring&type=&language=)


# 2 Preparation

Get yourself a free Openshift 4 cluster for a couple of hours:

[IBM Open Labs](https://developer.ibm.com/openlabs/openshift)

Get the login (right top side of the OCP console, IAM, copy login command).

Login to the cluster:

    oc login --token=... --server=...


## a) Configuration

    git clone https://github.com/kitty-catt/bc-full.git
    cd bc-full   
    cp scripts/config ~/config.bc-full
    ln -sf ~/config.bc-full ~/config
    vi ~/config


## b) Setup Tools

    cd tools && \
    bash setup.sh && \
    cd .. 

When the script is run, then it will install:
1. the openshift pipeline operator
2. sonarqube. 
3. create an apache httpd server called the silver platter where reports are stored of maven site scans, and jmeter runs.

Make a user to access the silver platter:

    bash tools/httpd/provide_access.sh

Note: the site scan will reveal vulnerabilities in the dependencies and source. That something to consider when you were to apply such a setup on your customers code, ... 


## c) Pipeline Resources

Configure the yaml files in tekton-resources when you want to push to your own quay account of build from your own forks. Otherwise use the defaults.


## d) Setup Application Foundations

The following commands will setup the namespace full-bc on your OCP4 cluster.

    bash scripts/setup.sh

When the script is run, then it will install:
1. the pipelines;
2. the foundational databases and load them (it will take about 1 or 2 minutes until the database is ready). 


# 3 Lets GO!

## a) Build the microservices

Build the container images via the 

    bash scripts/build.sh

Wait till the build gets in state completed:

    watch "oc get po | grep pipeline"

## b) Deploy the microservices

Deploy the microservices.

    bash scripts/deploy.sh


Note: in the OCP console you can inspect the status of the deployments in the namespace (default = full-bc)

    oc whoami --show-console


## c) Make a user

    bash scripts/customers/make_user.sh

# Levelling up

## a) Level up the routes from HTTP to HTTPS

The default routes is are plain text http over tcp, ... so vulnerable to eavesdropping. Lets level them up to encrypted routes. 

    bash scripts/https-routes/level-up.sh

## b) Experimental pipeline to scan on CVE's

There is an experimental pipeline that will scan the customer-ms-spring microservices based on the NIST CVE database. The maven build will use the org.owasp.dependency-check-maven plugin to generate a maven site report. The report is presented on the silver-platter deployment that was created during the tools setup.

### spring-boot2 (does work)

    oc create -f tekton-tasks/kabanero-spring-boot2.yaml
    oc apply -f tekton-pipelines/pipeline-report-spring-boot2.yaml
    oc create -f tekton-pipeline-run/customer-run-experimental.yaml
    oc create -f tekton-pipeline-run/auth-run-experimental.yam

### java-openliberty (does not work yet)

    oc create -f tekton-pipelines/pipeline-report-java-liberty.yaml 
    oc apply -f tekton-resources/auth-ms-liberty-resources-fork.yaml
    # oc create -f tekton-pipeline-run/auth-ms-liberty-run-experimental.yaml 

## c) Experiment with auth-ms-openliberty microservice

TODO:
- throttling;
- scan via pipeline.

Note: not quite ready, will break the shop login in its current state. Need to reconfigure shop.

    bash scripts/auth-ms-openliberty/level-up.sh 

Test:

    AUTHMS=$(oc get routes | grep auth-ms-openliberty | awk '{ print $2 }')
    curl -k -d "grant_type=password&client_id=bluecomputeweb&client_secret=bluecomputewebs3cret&username=foo&password=bar&scope=openid" https://$AUTHMS/oidc/endpoint/OP/token | jq .


# 4 Tear Down

   oc delete project full-bc

