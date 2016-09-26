#!/bin/sh

if [ -f /etc/security/hadoop/hive.headless.keytab ]; then
	sudo -u hive kdestroy
	sudo -u hive kinit -k -t /etc/security/hadoop/hive.headless.keytab hive@EXAMPLE.COM
fi
sudo -u hive /usr/hdp/llap-slider/run.sh
