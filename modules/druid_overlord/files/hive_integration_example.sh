#!/bin/sh

# Build Hive master.
cd ~
git clone https://github.com/apache/hive
cd hive
mvn clean package -DskipTests -Pdist

# Install and configure.
mkdir ~/hivedist
cd ~/hivedist
mv ~/hive/packaging/target/apache-hive-*-bin.tar.gz .
tar -zxf apache-hive-*-bin.tar.gz
cd apache-hive-*-bin
cp bin/hive bin/hive.distro
cp /usr/bin/hive2 bin/hive

export HIVE_HOME=$(ls -d /home/vagrant/hivedist/apache-hive-*-SNAPSHOT-bin)
export HIVE_CONF_DIR=$HIVE_HOME/conf
cp /etc/hive2/conf/hive-site.xml conf/

# Setup some external tables.
cat<<EOF>create_table.sql
SET hive.druid.broker.address.default=druid.example.com:8082;
CREATE EXTERNAL TABLE wikiticker_kafka
STORED BY 'org.apache.hadoop.hive.druid.DruidStorageHandler'
TBLPROPERTIES ("druid.datasource" = "wikiticker-kafka");
EOF
