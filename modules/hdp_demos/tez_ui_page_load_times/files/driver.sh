#!/bin/sh

if [ X"$1" = "X" ]; then
	echo "Usage: $0 TezUI"
	echo "$0 hdp253.example.com:31337"
	exit 1
fi

python probe_tez_ui.py -s $1
python extract_text.py > features.csv
python model.py
