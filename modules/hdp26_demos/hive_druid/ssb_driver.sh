#!/bin/sh

sh /vagrant/modules/benchmetrics/files/ssb/00prepare.sh
sudo -u hdfs hdfs dfs -mkdir -p /druid/segments
sudo -u hdfs hdfs dfs -chown druid:druid /druid /druid/segments
sudo -u druid hive2 --service cli -f /vagrant/modules/hdp26_demos/hive_druid/index_ssb.sql
