#!/bin/sh

# Check for all the stuff I need to function.
for f in gcc ; do
	which $f > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo "Required program $f is missing. Please install or fix your path and try again."
		exit 1
	fi
done

echo "Building TPC-H Data Generator"
make clean
make
echo "TPC-H Data Generator built, you can now use tpcds-datagen.sh to generate data."
