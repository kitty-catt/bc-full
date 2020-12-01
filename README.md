# Purpose

This repository aims to deploy the full IBM Blue Compute shop with a single command into an Openshift Cluster with corresponding Tekton pipeline. The Tekton pipeline will build the repo's from source to container image. <br>

The following repositories are deployed: <br>

[IBM blue compute](https://github.com/ibm-garage-ref-storefront/?q=storefront-ui+OR+spring&type=&language=)


# Preparation

Get yourself a free Openshift 4 cluster for a couple of hours:

[IBM Open Labs](https://developer.ibm.com/openlabs/openshift)


## Configuration

    git clone https://github.com/kitty-catt/bc-full.git
    cd bc-full   
    cp scripts/config ~/config.bc-full
    ln -sf ~/config.bc-full ~/config
    vi ~/config


## Operators

1. deploy the openshift pipeline operator (in openshift);

Note: the appsody operator is not necessary as the pipeline only does an appsody build.


## Pipeline Resources

Configure the yaml files in tekton-resources when you want to push to your own quay account of build from your own forks. Otherwise use the defaults.


# Setup

The following commands will setup the namespace full-bc on your OCP4 cluster.

    oc login
    bash scripts/setup.sh

When the script is run, then it will install the pipeline and the foundational databases and load them. 


# Build

Build the container images via the 

    bash scripts/build.sh

Wait till the build gets in state completed:

    watch "oc get po | grep pipeline"

# Deploy

Deploy the microservices.

    bash scripts/deploy.sh


Note: in the OCP console you can inspect the status of the deployments in the namespace (default = full-bc)

    oc whoami --show-console


# Make a user

    bash scripts/customers/make_user.sh

# Level up the routes from HTTP to HTTPS

The default routes is are plain text http over tcp, ... so vulnerable to eavesdropping. Lets level them up to encrypted routes. 

    bash scripts/https-routes/level-up.sh


# Tear Down

   oc delete project full-bc

