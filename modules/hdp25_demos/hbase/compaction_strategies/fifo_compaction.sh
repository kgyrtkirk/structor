#!/bin/sh

set -x

read -p "Setup some environment stuff"

cat<<EOF>temp.txt
create 'x',
  {NAME=>'y', TTL=>'30'},
  {CONFIGURATION => {'hbase.hstore.defaultengine.compactionpolicy.class' => 'org.apache.hadoop.hbase.regionserver.compactions.FIFOCompactionPolicy', 'hbase.hstore.blockingStoreFiles' => 1000}}
EOF
hbase shell < temp.txt
