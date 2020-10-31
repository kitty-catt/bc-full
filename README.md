# Purpose

This repository aims to deploy the full IBM Blue Compute shop with a single command into an Openshift Cluster with corresponding Tekton pipeline. The Tekton pipeline will build the repo's from source to container image. <br>

The following repositories are deployed: <br>

[IBM blue compute](https://github.com/ibm-garage-ref-storefront/?q=spring&type=&language=)

# Preparation

## Configuration

    cp scripts/config ~/config
    vi ~/config

## Operators
1. deploy the openshift pipeline operator (in openshift);
2. deploy the appsody operator (in openshift);

## Pipeline Resources
1. configure the yaml files in tekton-resources;


# Setup

The following commands will setup the namespace full-bc on your OCP4 cluster.

    oc login
    git clone https://github.com/kitty-catt/bc-full.git
    cd bc-full
    bash scripts/setup.sh

When the script is run, then it will install and load the databases. Wait until the retry succeeds.

Next, the generic pipeline is created

# Build

Build the container images via the 

    bash scripts/build.sh

# Deploy

Deploy the microservices.

    bash scripts/deploy.sh


# Tear Down

   oc delete project full-bc

