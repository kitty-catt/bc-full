# Purpose

This repository aims to deploy the full IBM Blue Compute shop with a single command into an Openshift Cluster. <br>

The following repositories are deployed: <br>

[the IBM blue compute spring repo's](https://github.com/ibm-garage-ref-storefront/?q=spring&type=&language=)

# Setup

The following commands will setup the namespace full-bc on your OCP4 cluster.

    oc login
    git clone https://github.com/kitty-catt/bc-full.git
    cd bc-full
    bash scripts/setup.sh

NOTES: 
- when the script is run, then it will install the database and it will retry loading the database until it succeeds. Just have patience.

# Build


# Deploy


# Tear Down

   oc delete project bc-full

