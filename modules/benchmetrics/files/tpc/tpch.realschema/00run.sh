#!/bin/sh

cd /vagrant/modules/benchmetrics/files/tpc/tpch.realschema/queries
DATABASE=tpch_bin_flat_real_orc_2

hive --version | grep '^Hive 2'
if [ $? -eq 0 ]; then
	hive -d DB=${DATABASE} -f /vagrant/modules/benchmetrics/files/tpc/tpch.realschema/queries/skip-q11-serial.sql
else
	hive -d DB=${DATABASE} -f /vagrant/modules/benchmetrics/files/tpc/tpch.realschema/queries/skip-q19-serial.sql
fi
