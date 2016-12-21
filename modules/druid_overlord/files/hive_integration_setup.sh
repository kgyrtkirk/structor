#!/bin/sh

# Start the ingestion job now so it will be ready for the external table later.
sh /home/vagrant/wikiticker-kafka/wikitickerKafkaDemo.sh

set hive.aux.jars.path=/usr/hdp/current/hive-server2-hive2/lib/hive-druid-handler.jar,/usr/hdp/2.6.0.0-228/hive2/lib/calcite-druid-1.10.0.2.6.0.0-228.jar,/usr/hdp/2.6.0.0-228/hive2/lib/calcite-core-1.10.0.2.6.0.0-228.jar,/usr/hdp/2.6.0.0-228/hive2/lib/calcite-linq4j-1.10.0.2.6.0.0-228.jar;
export HIVE_AUX_JARS_PATH=/usr/hdp/current/hive-server2-hive2/lib/hive-druid-handler.jar
echo "export HIVE_AUX_JARS_PATH=/usr/hdp/current/hive-server2-hive2/lib/hive-druid-handler.jar"

# Setup some external tables.
cat<<EOF>create_table.sql
SET hive.druid.broker.address.default=druid.example.com:8082;
CREATE EXTERNAL TABLE if not exists wikiticker_kafka
STORED BY 'org.apache.hadoop.hive.druid.DruidStorageHandler'
TBLPROPERTIES ("druid.datasource" = "wikiticker-kafka");
EOF
hive -f create_table.sql
