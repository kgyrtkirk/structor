#!/bin/sh

TPCDS=0
LLAP=1
DATE=$(date "+%Y-%m-%d")

mkdir -p dashboard_data

if [ $TPCDS -eq 1 ]; then
	pushd ~/src/structor
	switchProfile hdp260
	popd
	python benchmetrics.py -e hdp260 -s -c hive -p compatibility -t tpcds.trunk > dashboard_data/tpcds.$DATE.txt
	pushd dashboard_data
	egrep '^FAIL|^Error|^UNMODIFIE' tpcds.$DATE.txt > tpcds.$DATE.min.txt
	popd
fi

if [ $LLAP -eq 1 ]; then
	pushd dashboard_data
	python /Users/carter/bin/getLatestSuperappStatus.py > llap.$DATE.txt
	popd
fi
