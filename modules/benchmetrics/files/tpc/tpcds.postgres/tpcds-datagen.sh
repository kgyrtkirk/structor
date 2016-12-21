#!/bin/bash

function usage {
	echo "Usage: tpcds-setup.sh scale_factor [temp_directory]"
	exit 1
}

TARGET_DIR=target/v1.4.0/tools
TARGET=$TARGET/dsdgen
if [ ! -f $TARGET ]; then
	echo "Please build the data generator with ./tpcds-build.sh first"
	exit 1
fi
which psql > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Script must be run where Postgres is installed"
	exit 1
fi

# Get the parameters.
SCALE=$1
DIR=${2:/tmp/tpcds-generate}
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
psql -c 'select count(*) from reason'
if [ $? -ne 0 ]; then
	echo "Generating data at scale factor $SCALE in $DIR."
	mkdir -p $DIR
	cp $TARGET $DIR
	cp $TARGET_DIR/tpcds.idx $DIR
	cp ddl/text/alltables.sql $DIR
	cd $DIR
	./dsdgen -sc $SCALE -rngseed 12345
	for table in call_center catalog_page catalog_sales catalog_returns customer customer_address customer_demographics date_dim household_demographics income_band inventory item promotion reason ship_mode store store_sales store_returns time_dim warehouse web_page web_sales web_returns web_site; do
		sed -i s'/.$//' $table.dat
	done

	echo "Loading text data to Postgres."
	psql -f alltables.sql
fi
echo "TPC-DS text data generation complete."
