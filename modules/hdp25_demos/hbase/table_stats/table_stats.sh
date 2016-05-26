#!/bin/sh

sudo yum install jq

read -p 'Look at all the table level metrics'
curl -s localhost:16030/jmx | jq -M '.beans[] | select(.name == "Hadoop:service=HBase,name=RegionServer,sub=Tables")'

read -p 'Sort the busiest tables from a read perspective'
curl -s localhost:16030/jmx | jq -M '.beans[] | select(.name == "Hadoop:service=HBase,name=RegionServer,sub=Tables")' | grep readRequestCount | sed 's/,//g' | sort -k2 -n
