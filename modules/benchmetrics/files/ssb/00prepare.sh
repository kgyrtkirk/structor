#!/bin/sh

SCALE=${1:-2}

/vagrant/modules/benchmetrics/files/cleanYarn.sh
sudo service hive-server2 stop
sudo service hive2-server2 stop
sudo usermod -a -G hadoop vagrant
sudo sh /vagrant/modules/maven/files/maven.sh

# Don't do anything if the data is already loaded.
hdfs dfs -ls /apps/hive/warehouse/ssb_$SCALE_flat_orc.db >/dev/null

if [ $? -ne 0 ];  then
	# CentOS 7 doesn't have this one pre-installed.
	sudo yum install -y unzip

	# Build it.
	echo "Building the data generator"
	cd /vagrant/modules/benchmetrics/files/ssb/ssb-gen
	make

	# Generate and optimize the data.
	echo "Generate the data at scale $SCALE"
	hadoop jar target/ssb-gen-1.0-SNAPSHOT.jar -d /tmp/ssb/${SCALE}/ -s ${SCALE}
	hive -e "create database ssb_${SCALE}_raw; create database ssb_${SCALE}_flat_orc;"
	hive --database ssb_${SCALE}_raw -d LOCATION=/tmp/ssb/${SCALE} -f ddl/text.sql
	hive --database ssb_${SCALE}_flat_orc -d SOURCE=ssb_${SCALE}_raw -f ddl/orc_flat.sql
	hive --database ssb_${SCALE}_flat_orc -d SOURCE=ssb_${SCALE}_raw -f ddl/analyze_flat.sql;
else
	echo "SSB Data already loaded."
fi
