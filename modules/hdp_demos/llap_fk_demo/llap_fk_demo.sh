#!/bin/sh

set -x

SCALE=${1:-2}

# TPC-H base data load.
/vagrant/modules/benchmetrics/files/tpc/tpch/00prepare.sh $SCALE

# Add additional splits for the large tables to increase parallelism.
TABLES="customer lineitem orders partsupp"

mkdir -p /tmp/llap
cd /tmp/llap

echo "Optimizing large tables"
for t in $TABLES; do
	mkdir -p $t
	pushd $t
	hdfs dfs -copyToLocal /tmp/tpch-generate/$SCALE/$t/data-m-* .
	rm -f data.csv
	for f in data-m-*.deflate; do
		openssl zlib -d < $f >> data.csv
	done

	# Split the data 8 ways.
	python /vagrant/modules/hdp_demos/llap_fk_demo/splitter.py
	wc -l split*
	hdfs dfs -rm /tmp/tpch-generate/$SCALE/$t/data-m-*
	hdfs dfs -copyFromLocal -f split* /tmp/tpch-generate/$SCALE/$t
	popd
done

# Re-create everything.
echo "Loading new tables"
hive -d DB=tpch_bin_flat_orc_$SCALE -d FILE=orc -d SOURCE=tpch_text_$SCALE -f /vagrant/modules/benchmetrics/files/tpc/tpch/ddl/bin_flat/alltables.sql

# Load the keys.
echo "Loading PK/FK"
beeline -u jdbc:hive2://llap.example.com:10000/tpch_bin_flat_orc_$SCALE -f /vagrant/modules/benchmetrics/files/tpc/tpch/ddl/bin_flat/add_constraints.sql

rm -rf /tmp/llap
echo "Done, launch LLAP and connect BI tool to port 10000"
