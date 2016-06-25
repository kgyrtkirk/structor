#!/bin/sh

set -x

read -p "Review the configuration"
echo -en "\033[31m"
cat /vagrant/modules/hdp25_demos/hive/stored_procedure/hplsql-site.xml
echo -en "\033[0m"

read -p "We will track state in a MySQL table, examine that"
echo -en "\033[31m"
cat /vagrant/modules/hdp25_demos/hive/stored_procedure/mysql_setup.sql
echo -en "\033[0m"

read -p "Examine the load process. Note in particular PART_STRING and EXECUTE features."
echo -en "\033[31m"
cat /vagrant/modules/hdp25_demos/hive/stored_procedure/addpartition.hplsql
echo -en "\033[0m"

read -p "Query the initial state in MySQL"
echo "select count(*) from hive.state" | mysql -uhive -pvagrant

read -p "Look at the current partition structure"
hdfs dfs -lsr /apps/hive/warehouse/citydata.db

read -p "Run the HPL/SQL script"
hplsql -f /vagrant/modules/hdp25_demos/hive/stored_procedure/addpartition.hplsql

read -p "Look at the updated partition structure"
hdfs dfs -lsr /apps/hive/warehouse/citydata.db

read -p "Query the final state in MySQL"
echo "select * from hive.state" | mysql -uhive -pvagrant
