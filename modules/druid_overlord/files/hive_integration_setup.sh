#!/bin/sh

sudo mkdir -p /usr/hdp/current/hive-server2-hive2/auxlib
sudo cp /usr/hdp/current/hive-server2-hive2/lib/hive-druid-handler.jar /usr/hdp/current/hive-server2-hive2/auxlib
sudo cp /usr/hdp/current/hive-server2-hive2/lib/calcite* /usr/hdp/current/hive-server2-hive2/auxlib
sudo systemctl restart hive2-server2

# Setup some external tables.
cat<<EOF>create_table.sql
SET hive.druid.broker.address.default=druid.example.com:8082;
CREATE EXTERNAL TABLE if not exists wikiticker_kafka
STORED BY 'org.apache.hadoop.hive.druid.DruidStorageHandler'
TBLPROPERTIES ("druid.datasource" = "wikiticker-kafka");
EOF
hive2 --service cli -f create_table.sql
