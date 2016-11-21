#!/bin/sh

sudo systemctl stop hive-server2
sudo systemctl stop hive2-server2
sudo systemctl stop hive-metastore

cd ~/hivedist/apache-hive-*-bin
bin/schematool -dbType mysql -upgradeSchema
bin/hive --service metastore & bin/hive --service hiveserver2 --hiveconf hive.root.logger=DEBUG,console
