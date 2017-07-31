#!/bin/sh

for job in $(yarn application -list 2>/dev/null | tail -n +3 | awk '{print $1}'); do
	yarn application -kill $job
done
