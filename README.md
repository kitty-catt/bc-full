# Purpose

This repository aims to deploy the full IBM Blue Compute shop with a single command into an Openshift Cluster.


# Setup

The following commands will setup the namespace full-bc on your OCP4 cluster.

    oc login
    git clone https://github.com/kitty-catt/bc-full.git
    cd bc-full
    bash scripts/setup.sh


# Tear Down

   oc delete project bc-full

