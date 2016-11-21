#!/bin/sh

sudo service hive-server2 start
sudo service hive2-server2 start

sleep 5

rm -f fails.txt
TOTAL=0
SUCCESS=0
for f in /vagrant/modules/benchmetrics/files/compatibility/tpcds/explains/query*.sql; do
	echo "Running $f"
	beeline -u jdbc:hive2://localhost:10000/tpcds_schema -f $f >/dev/null 2>fail.txt
	if [ $? -eq 0 ]; then
		SUCCESS=`expr $SUCCESS + 1`
	else
		echo "FAIL: $f" >> fails.txt
		cat fail.txt >> fails.txt
	fi
	TOTAL=`expr $TOTAL + 1`
done

echo "$SUCCESS of $TOTAL"
