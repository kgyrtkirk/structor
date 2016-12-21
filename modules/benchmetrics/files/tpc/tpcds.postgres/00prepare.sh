#!/bin/sh

SCALE=${1-2}

# Don't do anything if the data is already loaded.
psql -c 'select count(*) from reason'
if [ $? -ne 0 ];  then
	# CentOS 7 doesn't have this one pre-installed.
	sudo yum install -y unzip

	# Build it.
	echo "Building the data generator"
	cd /vagrant/modules/benchmetrics/files/tpc/tpcds.postgres
	sh /vagrant/modules/benchmetrics/files/tpc/tpcds.postgres/tpcds-build.sh

	# Generate and load the data.
	echo "Generate the data at scale $SCALE"
	sh /vagrant/modules/benchmetrics/files/tpc/tpcds.postgres/tpcds-datagen.sh $SCALE
else
	echo "TPC-DS Data already loaded."
fi
