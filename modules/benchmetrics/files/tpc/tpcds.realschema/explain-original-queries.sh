#!/bin/sh

# Run through Hive 2.
sudo service hive-server2 stop
sleep 10
sudo service hive2-server2 start
sleep 15

# Capture the explains themselves.
QUERYDIR=/vagrant/modules/benchmetrics/files/tpc/tpcds.realschema/queries/originals
DATABASE=tpcds_real_bin_partitioned_orc_2
mkdir -p /tmp/explain-output
cd /tmp/explain-output
for query in $(ls $QUERYDIR); do
	echo $query
	echo "explain" > $query
	cat $QUERYDIR/$query >> $query
	beeline -f $query -u jdbc:hive2://localhost:10000/$DATABASE vagrant vagrant > $query.out 2>$query.err
done
