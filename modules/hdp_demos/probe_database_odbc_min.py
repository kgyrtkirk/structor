import pyodbc
import sys

def main():
	try:
		connect = sys.argv[1]
	except:
		connect = "DSN=Postgres"
		connect = "DSN=Hortonworks Hive DSN;DATABASE=default;DB=default;UID=vagrant;PWD=vagrant"
	connection = pyodbc.connect(connect, autocommit=True)

	cursor = connection.cursor()
	tables = []
	print "=== Tables ==="
	for row in cursor.tables():
		print(row)
		tables.append(row)

	probes = [
		( "Statistics", "statistics" ),
		( "ID Columns", "rowIdColumns" ),
		( "Primary Keys", "primaryKeys" ),
		( "Foreign Keys", "foreignKeys" ),
		( "Procedures", "procedures" ),
	]
	for probe in probes:
		probeName = probe[0]
		method = probe[1]
		print "=== {0} ===".format(probeName)
		try:
			for tuple in tables:
				catalog = tuple[0]
				schema = tuple[1]
				table = tuple[2]
				code = "for row in cursor.{0}(table, catalog=catalog, schema=schema): print(row)".format(method)
				exec code
		except:
			print "Got an error from the server!"

	columns = [ "table_cat", "table_schem", "table_name", "column_name", "data_type", "type_name",
		    "column_size", "buffer_length", "decimal_digits", "num_prec_radix",
		    "nullable", "remarks", "column_def", "sql_data_type", "sql_datetime_sub",
		    "char_octet_length", "ordinal_position", "is_nullable" ]
	print "=== Columns ==="
	for row in cursor.columns():
		key_vals = zip(columns, row)
		for x in key_vals:
			print "{0}={1},".format(x[0], x[1]),
		print
		print

main()
