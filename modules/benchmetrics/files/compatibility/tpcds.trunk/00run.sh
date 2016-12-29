#!/bin/sh

sleep 5

# Load the data.
/vagrant/modules/benchmetrics/files/tpc/tpcds.schemaonly/00prepare.sh

rm -f tpcds.trunk.txt
TOTAL=0
SUCCESS=0
for f in /vagrant/modules/benchmetrics/files/compatibility/tpcds/explains/query*.sql; do
	echo "Running $f"
	beeline -u jdbc:hive2://localhost:10000/tpcds_schema -f $f >/dev/null 2>fail.txt
	if [ $? -eq 0 ]; then
		SUCCESS=`expr $SUCCESS + 1`
	else
		echo "FAIL: $f" >> tpcds.trunk.txt
		cat fail.txt >> tpcds.trunk.txt
	fi
	TOTAL=`expr $TOTAL + 1`
done

MESSAGE="UNMODIFIED QUERIES RUN: $SUCCESS of $TOTAL"
echo $MESSAGE >> tpcds.trunk.txt
echo $MESSAGE
cat tpcds.trunk.txt
