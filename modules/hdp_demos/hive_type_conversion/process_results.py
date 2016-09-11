#!/usr/bin/python

import csv
import re
import sys

translate = {
	"org.apache.hadoop.hive.serde2.io.DoubleWritable" : "double",
	"org.apache.hadoop.hive.serde2.io.HiveDecimalWritable" : "decimal",
	"org.apache.hadoop.io.LongWritable" : "bigint",
	"org.apache.hadoop.hive.serde2.io.TimestampWritable" : "timestamp",
	"org.apache.hadoop.hive.serde2.io.DateWritable" : "date",
	"org.apache.hadoop.io.Text" : "string",
	"org.apache.hadoop.io.FloatWritable" : "float",
	"org.apache.hadoop.io.IntWritable" : "int",
	"org.apache.hadoop.hive.serde2.io.ShortWritable" : "smallint",
}

mapping = {}
mapping["binary"] = {}
file = open("blackbox.txt")
found_types = False
for line in file:
	match = re.match("(\S+) : (\S+)", line)
	if match:
		type1 = match.group(1)
		type2 = match.group(2)
		offset1 = type1.find("(")
		offset2 = type2.find("(")
		if offset1 > -1:
			type1 = type1[0:offset1]
		if offset2 > -1:
			type2 = type2[0:offset2]
		found_types = True
	if found_types:
		match = re.match("\d: (\S+)", line)
		if match:
			#print match.group(1), type1, type2
			type = translate[match.group(1)]
			#print "\t".join([type1, type2, type])
			if type1 not in mapping:
				mapping[type1] = {}
			mapping[type1][type2] = type
			found_types = False
		match = re.match("NULL", line)
		if match:
			#print "\t".join([type1, type2, "NA"])
			if type1 not in mapping:
				mapping[type1] = {}
			mapping[type1][type2] = "NA"
			found_types = False

types = sorted(mapping.keys())
matrix = [["" for x in range(len(types))] for y in range(len(types))] 
for i1 in range(len(types)):
	t1 = types[i1]
	for i2 in range(len(types)):
		t2 = types[i2]
		if t1 == t2:
			matrix[i1][i2] = t1
		else:
			if t1 in mapping and t2 in mapping[t1]:
				matrix[i1][i2] = mapping[t1][t2]
			else:
				matrix[i1][i2] = "NA"

# Output a conversion matrix.
fd = open("conversion.csv", "w")
writer = csv.writer(fd)
header = [""]
header.extend(types)
writer.writerow(header)
for i in range(len(types)):
	row = [types[i]]
	row.extend(matrix[i])
	writer.writerow(row)
