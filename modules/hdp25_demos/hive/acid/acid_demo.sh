#!/bin/sh

mkfifo /tmp/fifo
hive -f /vagrant/modules/hdp25_demos/hive/acid/acid_demo.sql
