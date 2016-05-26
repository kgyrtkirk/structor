#!/bin/sh

set -x

read -p "Adding some sample data and views"
hdfs dfs -mkdir -p /user/vagrant/column_masking
hdfs dfs -copyFromLocal -f /vagrant/modules/hdp25_demos/hive/column_masking/sample_data.asv /user/vagrant/column_masking
hive -f /vagrant/modules/hdp25_demos/hive/column_masking/load_masking_data.sql

read -p "Demonstrate masking features"
hive -f /vagrant/modules/hdp25_demos/hive/column_masking/demo_masking_features.sql
