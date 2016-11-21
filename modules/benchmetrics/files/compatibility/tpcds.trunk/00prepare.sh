#!/bin/sh

# Generate the data.
/vagrant/modules/benchmetrics/files/tpc/tpcds.schemaonly/00prepare.sh

# Deploy hive trunk.
/vagrant/modules/hive_trunk/files/build_hive_trunk.sh

# Enable services.
/vagrant/modules/hive_trunk/files/trunk_hs2.sh
