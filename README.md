# 1 Purpose

This repository aims to deploy the full IBM Blue Compute shop with a single command into an Openshift Cluster with corresponding Tekton pipeline. The Tekton pipeline will build the repo's from source to container image. <br>

The following repositories are deployed: <br>

[IBM blue compute](https://github.com/ibm-garage-ref-storefront/?q=storefront-ui+OR+spring&type=&language=)


# 2 Preparation

Get yourself a free Openshift 4 cluster for a couple of hours:

[IBM Open Labs](https://developer.ibm.com/openlabs/openshift)


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


## c) Pipeline Resources

Configure the yaml files in tekton-resources when you want to push to your own quay account of build from your own forks. Otherwise use the defaults.


## d) Setup Application Foundations

The following commands will setup the namespace full-bc on your OCP4 cluster.

    oc login
    bash scripts/setup.sh

When the script is run, then it will install the pipeline and the foundational databases and load them. 

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

## d) Level up the routes from HTTP to HTTPS

The default routes is are plain text http over tcp, ... so vulnerable to eavesdropping. Lets level them up to encrypted routes. 

    bash scripts/https-routes/level-up.sh

## e) Experimental pipeline

There is an experimental pipeline that will scan the customer-ms-spring microservices based on the NIST CVE database. The maven build will use the org.owasp.dependency-check-maven plugin to generate a maven site report. The report is presented on the silver-platter deployment that was created during the tools setup.

    oc apply -f tekton-tasks/kabanero-maven.yaml
    oc apply -f tekton-pipelines/pipeline-report.yaml
    oc create -f tekton-pipeline-run/customer-run-experimental.yaml 


# 4 Tear Down

   oc delete project full-bc

