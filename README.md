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

Configure the yaml files in tekton-resources (only if you want to push to your own quay account of build from your own forks).

    vi tekton-resources/inventory-resources.yaml
    vi tekton-resources/catalog-resources.yaml
    vi tekton-resources/customer-resources.yaml


# Setup

The following commands will setup the namespace full-bc on your OCP4 cluster.

    oc login
    bash scripts/setup.sh

When the script is run, then it will:
- initialize the generic tekton pipeline.
- install the mysql database for the inventory microservice [architecture](https://github.com/ibm-garage-ref-storefront/inventory-ms-spring). 
- wait until the mysql database is up and ready, this will take a minute or 2 &#x1F634;.
- load the inventory database.
- install the elastic search database for the catalog microservice [architecture](https://github.com/ibm-garage-ref-storefront/catalog-ms-spring)
- install the CouchDB database for the customer microservice [architecture](https://github.com/ibm-garage-ref-storefront/customer-ms-spring)

# Build

Build the container images via the 

    bash scripts/build.sh

# Deploy

Deploy the microservices.

    bash scripts/deploy.sh


# Test

Test the microservices.

    bash scripts/test.sh

# Tear Down

   oc delete project full-bc

