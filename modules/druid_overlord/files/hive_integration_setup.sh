#!/bin/sh

# Start the ingestion job now so it will be ready for the external table later.
sh /home/vagrant/wikiticker-kafka/wikitickerKafkaDemo.sh

# Build Hive master.
/vagrant/modules/hive_trunk/files/build_hive_trunk.sh
export HIVE_HOME=$(ls -d /home/vagrant/hivedist/apache-hive-*-SNAPSHOT-bin)
export HIVE_CONF_DIR=$HIVE_HOME/conf
export PATH=$HIVE_HOME/bin:$PATH

# Add additional JARs we need
JARS="hive-druid-handler-2.2.0-SNAPSHOT.jar calcite-druid-1.10.0.jar calcite-core-1.10.0.jar calcite-linq4j-1.10.0.jar"
DIR="/tmp/druid-jars"
mkdir -p $DIR
for f in $JARS; do
	cp $HIVE_HOME/lib/$f $DIR
done
export HIVE_AUX_JARS_PATH=$DIR/hive-druid-handler-2.2.0-SNAPSHOT.jar,$DIR/calcite-druid-1.10.0.jar,$DIR/calcite-core-1.10.0.jar,$DIR/calcite-linq4j-1.10.0.jar
echo "export HIVE_AUX_JARS_PATH=$DIR/hive-druid-handler-2.2.0-SNAPSHOT.jar,$DIR/calcite-druid-1.10.0.jar,$DIR/calcite-core-1.10.0.jar,$DIR/calcite-linq4j-1.10.0.jar" >> ~/.bash_profile

# Setup some external tables.
cat<<EOF>create_table.sql
SET hive.druid.broker.address.default=druid.example.com:8082;
CREATE EXTERNAL TABLE if not exists wikiticker_kafka
STORED BY 'org.apache.hadoop.hive.druid.DruidStorageHandler'
TBLPROPERTIES ("druid.datasource" = "wikiticker-kafka");
EOF
hive -f create_table.sql
