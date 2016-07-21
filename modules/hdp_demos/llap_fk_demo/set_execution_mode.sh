#!/bin/sh

MODE=$1

if [ $MODE -eq "llap" ]; then
	sudo systemctl restart hive2-server2
elsif [ $MODE -eq "container" ]; then
	sudo systemctl restart hive2-server2
else
fi
