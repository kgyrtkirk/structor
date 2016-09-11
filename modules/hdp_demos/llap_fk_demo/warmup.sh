#!/bin/sh

i=0
while [ $i -lt 100 ]; do
	time python /vagrant/modules/hdp_demos/llap_fk_demo/warmup.py
	free
	i=`expr $i + 1`
done
