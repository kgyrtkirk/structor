#!/bin/sh

SCALE=${1:-2}
export PATH=$PATH:/usr/local/share/maven/bin

/vagrant/modules/maven/files/install_maven_manually.sh
/vagrant/modules/benchmetrics/files/cleanYarn.sh
sudo service hive-server2 stop
sudo service hive2-server2 stop
sudo usermod -a -G hadoop vagrant
sudo sh /vagrant/modules/maven/files/maven.sh

# Don't do anything if the data is already loaded.
hdfs dfs -ls /apps/hive/warehouse/ssb_${SCALE}_flat_orc.db >/dev/null

if [ $? -ne 0 ];  then
	# CentOS 7 doesn't have this one pre-installed.
	sudo yum install -y unzip

	# Build it.
	echo "Building the data generator"
	cd /vagrant/modules/benchmetrics/files/ssb/ssb-gen
	make clean all

	# Generate and optimize the Hive data.
	echo "Generate the data at scale $SCALE"
	hadoop jar target/ssb-gen-1.0-SNAPSHOT.jar -d /tmp/ssb/${SCALE}/ -s ${SCALE}
	hive -e "create database ssb_${SCALE}_raw; create database ssb_${SCALE}_flat_orc;"
	hive --database ssb_${SCALE}_raw -d LOCATION=/tmp/ssb/${SCALE} -f ddl/text.sql
	hive --database ssb_${SCALE}_flat_orc -d SOURCE=ssb_${SCALE}_raw -f ddl/orc_flat.sql
	hive --database ssb_${SCALE}_flat_orc -d SOURCE=ssb_${SCALE}_raw -f ddl/analyze_flat.sql;

	# Load the data into Druid.
	cd /vagrant/modules/benchmetrics/files/ssb
	sudo -u hdfs hdfs dfs -mkdir -p /druid/segments
	sudo -u hdfs hdfs dfs -chown -R druid:druid /druid
	sudo -u druid hive -f queries.druid/index_ssb.sql
else
	echo "SSB Data already loaded."
fi
