#!/bin/sh

set -x

SCALE=${1:-2}

# Load the keys.
echo "Loading PK/FK"
beeline -u jdbc:hive2://llap.example.com:10000/tpch_bin_flat_orc_$SCALE -f /vagrant/modules/benchmetrics/files/tpc/tpch/ddl/bin_flat/add_constraints.sql
