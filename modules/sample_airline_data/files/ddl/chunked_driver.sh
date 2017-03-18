#!/bin/sh

set -x

hive2 --service cli -f /vagrant/modules/sample_airline_data/files/ddl/chunked1.sql
sleep 30
/vagrant/modules/benchmetrics/files/cleanYarn.sh
hive2 --service cli -f /vagrant/modules/sample_airline_data/files/ddl/chunked2.sql
sleep 30
/vagrant/modules/benchmetrics/files/cleanYarn.sh
hive2 --service cli -f /vagrant/modules/sample_airline_data/files/ddl/chunked3.sql
sleep 30
/vagrant/modules/benchmetrics/files/cleanYarn.sh
hive2 --service cli -f /vagrant/modules/sample_airline_data/files/ddl/chunked4.sql
sleep 30
/vagrant/modules/benchmetrics/files/cleanYarn.sh
hive2 --service cli -f /vagrant/modules/sample_airline_data/files/ddl/analyze.sql

