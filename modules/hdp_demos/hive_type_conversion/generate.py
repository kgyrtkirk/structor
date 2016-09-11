#!/usr/bin/python

import itertools

types = {
	# Numerics
	"tinyint":        "10",
	"smallint":       "10",
	"int":            "10",
	"bigint":         "10",
	"float":          "10.0",
	"double":         "10.0",
	"decimal(10,4)": "10.0",

	# Date/Time
	"timestamp":      '"2012-01-01 00:00:00"',
	"date":           '"2012-01-01"',

	# Strings
	"string":         '"X"',
	"varchar(10)":    '"X"',
	"char(10)":       '"X"',

	# Misc
	"boolean":        "true",
	"binary":         '"10"',
}
string_values = {
	"integer"   : '"10"',
	"float"     : '"10.0"',
	"date"      : '"2012-01-01"',
	"timestamp" : '"2012-01-01 00:00:00"',
	"boolean"   : '"true"',
	"binary"    : '"10"'
}

string_types = {
	"string"      : 1,
	"varchar(10)" : 1,
	"char(10)"    : 1
}
integer_types = {
	"tinyint"  : 1,
	"smallint" : 1,
	"int"      : 1,
	"bigint"   : 1,
}
float_types = {
	"float"    : 1,
	"double"   : 1,
	"decimal(10,4)" : 1
}
date_types = {
	"timestamp" : 1,
	"date" : 1
}

def substitute(other_type):
	if other_type in integer_types:
		return string_values["integer"]
	if other_type in float_types:
		return string_values["float"]
	if other_type == "date":
		return string_values["date"]
	if other_type == "timestamp":
		return string_values["timestamp"]
	if other_type == "boolean":
		return string_values["boolean"]
	if other_type == "binary":
		return string_values["binary"]
	else:
		return '"xyzzy"'

print "create temporary function mycompare as 'com.mycompany.hiveudf.GenericUDFOPEqualTypes';"
for pair in itertools.permutations(types.keys(), 2):
	base_type1 = pair[0]
	base_type2 = pair[1]
	value1 = types[pair[0]]
	value2 = types[pair[1]]

	if base_type1 in string_types:
		value1 = substitute(base_type2)
	if base_type2 in string_types:
		value2 = substitute(base_type1)

	has_string = False
	if base_type1 in string_types or base_type2 in string_types:
		has_string = True
	has_integer = False
	if base_type1 in integer_types or base_type2 in integer_types:
		has_integer = True
	has_float = False
	if base_type1 in float_types or base_type2 in float_types:
		has_float = True
	has_date = False
	if base_type1 in date_types or base_type2 in date_types:
		has_date = True
	has_binary = False
	if base_type1 == "binary" or base_type2 == "binary":
		has_binary = True
	has_timestamp = False
	if base_type1 == "timestamp" or base_type2 == "timestamp":
		has_timestamp = True
	has_date = False
	if base_type1 == "date" or base_type2 == "date":
		has_date = True
	has_boolean = False
	if base_type1 == "boolean" or base_type2 == "boolean":
		has_boolean = True

	# Blacklist some combinations.
	if has_string and has_binary:
		continue
	if has_integer and has_binary:
		continue
	if has_float and has_binary:
		continue
	if has_timestamp and has_binary:
		continue
	if has_date and has_binary:
		continue
	if has_boolean and has_binary:
		continue
	if has_date and has_boolean:
		continue

	type1 = "cast({0} as {1})".format(value1, base_type1)
	type2 = "cast({0} as {1})".format(value2, base_type2)
	query = "select mycompare({0}, {1});".format(type1, type2)

	print "!echo {0} : {1};".format(base_type1, base_type2)
	print query
