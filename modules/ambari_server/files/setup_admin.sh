#!/bin/sh

sudo adduser admin
sudo -u hdfs hdfs dfs -mkdir /user/admin
sudo -u hdfs hdfs dfs -chown admin:admin /user/admin

sudo -u hdfs hdfs dfs -mkdir /user/vagrant
sudo -u hdfs hdfs dfs -chown vagrant:vagrant /user/vagrant
