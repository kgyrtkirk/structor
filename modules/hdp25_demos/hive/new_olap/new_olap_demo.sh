#!/bin/sh

mkfifo /tmp/fifo
hive2 -f /vagrant/modules/hdp25_demos/hive/new_olap/new_olap.sql
