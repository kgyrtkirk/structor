#!/bin/sh

BEELINE="beeline -u jdbc:hive2://localhost:10000/default"

echo "Load Integer table"
$BEELINE -f 9queens_create_int.sql

echo "Warmup"
$BEELINE -f warmup.sql

for type in tinyint smallint int bigint float double decimal; do
	echo "Load $type table"
	$BEELINE -f 9queens_create_$type.sql
	echo "Run $type vectorization on"
	$BEELINE -f 9queens_run.sql --hivevar VECTORIZATION_ON=true
	echo "Run $type vectorization off"
	$BEELINE -f 9queens_run.sql --hivevar VECTORIZATION_ON=false
done
