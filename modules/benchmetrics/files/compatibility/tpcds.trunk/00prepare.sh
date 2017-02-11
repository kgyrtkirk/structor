#!/bin/sh

# Deploy hive trunk.
/vagrant/modules/hive_trunk/files/build_hive_trunk.sh

# Generate the data after we wait for HDFS to settle.
/vagrant/modules/benchmetrics/files/tpc/tpcds.schemaonly/00prepare.sh

# Enable services.
/vagrant/modules/hive_trunk/files/trunk_hs2.sh
