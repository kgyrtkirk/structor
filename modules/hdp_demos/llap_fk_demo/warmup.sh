#!/bin/sh

i=0
while [ $i -lt 100 ]; do
	time python warmup.py
	i=`expr $i + 1`
done
