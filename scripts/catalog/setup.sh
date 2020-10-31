#!/bin/bash

echo "setup catalog"

# Start an Elasticsearch Container
#docker run --name catalogelasticsearch \
#      -e "discovery.type=single-node" \
#      -p 9200:9200 \
#      -p 9300:9300 \
#      -d docker.elastic.co/elasticsearch/elasticsearch:6.3.2

oc new-app --name=catalogelasticsearch \
   -e "discovery.type=single-node" \
   --docker-image=docker.elastic.co/elasticsearch/elasticsearch:6.3.2

# Not recommended
oc expose svc catalogelasticsearch   