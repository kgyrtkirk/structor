#!/bin/bash

function usage {
	echo "Usage: tpch-setup.sh scale_factor [temp_directory]"
	exit 1
}

if [ ! -f target/tpch_2_17_0/dbgen/dbgen ]; then
	echo "Please build the data generator with ./tpch-build.sh first"
	exit 1
fi
which psql > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Script must be run where Postgres is installed"
	exit 1
fi

# Get the parameters.
SCALE=$1
if [ "X$DEBUG_SCRIPT" != "X" ]; then
	set -x
fi

# Sanity checking.
if [ X"$SCALE" = "X" ]; then
	usage
fi
if [ $SCALE -eq 1 ]; then
	echo "Scale factor must be greater than 1"
	exit 1
fi

# Do the actual data load.
DIR=/tmp/tpch-generate
psql -c 'select count(*) from nation'
if [ $? -ne 0 ]; then
	echo "Generating data at scale factor $SCALE."
	mkdir -p $DIR
	cp target/tpch_2_17_0/dbgen/dbgen $DIR
	cp target/tpch_2_17_0/dbgen/dists.dss $DIR
	cp ddl/text/alltables.sql $DIR
	cd $DIR
	./dbgen -f -s 2
	for table in customer lineitem nation orders partsupp part region supplier; do
		sed -i s'/.$//' $table.tbl
	done

	echo "Loading text data to Postgres."
	psql -f alltables.sql
fi
echo "TPC-H text data generation complete."
