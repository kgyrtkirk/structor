import pyodbc
import sys

def main():
	try:
		connect = sys.argv[1]
	except:
		connect = "DSN=Postgres"
		connect = "DSN=Hortonworks Hive DSN;DATABASE=default;DB=default;UID=vagrant;PWD=vagrant"
	connection = pyodbc.connect(connect, autocommit=True)
	attributes = sorted(info_attributes.split())
	for attribute in attributes:
		exec "x = pyodbc.{0}".format(attribute)
		try:
			result = connection.getinfo(x)
			if int(result) != 0:
				result = dump_hex_representation(result)
			print attribute, " = ", result
		except:
			pass

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
	probes = [
		( "Statistics", "statistics" ),
		( "ID Columns", "rowIdColumns" ),
		( "Primary Keys", "primaryKeys" ),
		( "Procedures", "procedures" ),
	]
	for probe in probes:
		probeName = probe[0]
		method = probe[1]
		print "=== {0} ===".format(probeName)
		for tuple in tables:
			catalog = tuple[0]
			schema = tuple[1]
			table = tuple[2]
			code = "for row in cursor.{0}(table, catalog=catalog, schema=schema): print(row)".format(method)
			exec code

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

info_attributes = """
	SQL_ACCESSIBLE_PROCEDURES
	SQL_ACCESSIBLE_TABLES
	SQL_ACTIVE_ENVIRONMENTS
	SQL_AGGREGATE_FUNCTIONS
	SQL_ALTER_DOMAIN
	SQL_ALTER_TABLE
	SQL_ASYNC_MODE
	SQL_BATCH_ROW_COUNT
	SQL_BATCH_SUPPORT
	SQL_BOOKMARK_PERSISTENCE
	SQL_CATALOG_LOCATION
	SQL_CATALOG_NAME
	SQL_CATALOG_NAME_SEPARATOR
	SQL_CATALOG_TERM
	SQL_CATALOG_USAGE
	SQL_COLLATION_SEQ
	SQL_COLLATION_SEQ
	SQL_COLUMN_ALIAS
	SQL_CONCAT_NULL_BEHAVIOR
	SQL_CONVERT_FUNCTIONS
	SQL_CORRELATION_NAME
	SQL_CREATE_ASSERTION
	SQL_CREATE_CHARACTER_SET
	SQL_CREATE_COLLATION
	SQL_CREATE_DOMAIN
	SQL_CREATE_SCHEMA
	SQL_CREATE_TABLE
	SQL_CREATE_TRANSLATION
	SQL_CURSOR_COMMIT_BEHAVIOR
	SQL_CURSOR_ROLLBACK_BEHAVIOR
	SQL_DATA_SOURCE_NAME
	SQL_DATA_SOURCE_READ_ONLY
	SQL_DDL_INDEX
	SQL_DEFAULT_TXN_ISOLATION
	SQL_DESCRIBE_PARAMETER
	SQL_DESCRIBE_PARAMETER
	SQL_DM_VER
	SQL_DRIVER_HDESC
	SQL_DRIVER_HDESC
	SQL_DRIVER_HENV
	SQL_DRIVER_HLIB
	SQL_DRIVER_HSTMT
	SQL_DRIVER_NAME
	SQL_DRIVER_ODBC_VER
	SQL_DRIVER_VER
	SQL_DROP_ASSERTION
	SQL_DROP_CHARACTER_SET
	SQL_DROP_COLLATION
	SQL_DROP_DOMAIN
	SQL_DROP_SCHEMA
	SQL_DROP_TABLE
	SQL_DROP_TRANSLATION
	SQL_DROP_VIEW
	SQL_DYNAMIC_CURSOR_ATTRIBUTES1
	SQL_DYNAMIC_CURSOR_ATTRIBUTES2
	SQL_EXPRESSIONS_IN_ORDERBY
	SQL_FILE_USAGE
	SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1
	SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2
	SQL_GETDATA_EXTENSIONS
	SQL_GROUP_BY
	SQL_IDENTIFIER_CASE
	SQL_IDENTIFIER_QUOTE_CHAR
	SQL_INDEX_KEYWORDS
	SQL_INFO_SCHEMA_VIEWS
	SQL_INSERT_STATEMENT
	SQL_INTEGRITY
	SQL_KEYSET_CURSOR_ATTRIBUTES1
	SQL_KEYSET_CURSOR_ATTRIBUTES2
	SQL_KEYWORDS
	SQL_LIKE_ESCAPE_CLAUSE
	SQL_MAX_ASYNC_CONCURRENT_STATEMENTS
	SQL_MAX_ASYNC_CONCURRENT_STATEMENTS
	SQL_MAX_BINARY_LITERAL_LEN
	SQL_MAX_CATALOG_NAME_LEN
	SQL_MAX_CHAR_LITERAL_LEN
	SQL_MAX_COLUMN_NAME_LEN
	SQL_MAX_COLUMNS_IN_GROUP_BY
	SQL_MAX_COLUMNS_IN_INDEX
	SQL_MAX_COLUMNS_IN_ORDER_BY
	SQL_MAX_COLUMNS_IN_SELECT
	SQL_MAX_COLUMNS_IN_TABLE
	SQL_MAX_CONCURRENT_ACTIVITIES
	SQL_MAX_CURSOR_NAME_LEN
	SQL_MAX_DRIVER_CONNECTIONS
	SQL_MAX_IDENTIFIER_LEN
	SQL_MAX_INDEX_SIZE
	SQL_MAX_PROCEDURE_NAME_LEN
	SQL_MAX_ROW_SIZE
	SQL_MAX_ROW_SIZE_INCLUDES_LONG
	SQL_MAX_SCHEMA_NAME_LEN
	SQL_MAX_STATEMENT_LEN
	SQL_MAX_TABLE_NAME_LEN
	SQL_MAX_TABLES_IN_SELECT
	SQL_MAX_USER_NAME_LEN
	SQL_MULTIPLE_ACTIVE_TXN
	SQL_MULT_RESULT_SETS
	SQL_NEED_LONG_DATA_LEN
	SQL_NON_NULLABLE_COLUMNS
	SQL_NULL_COLLATION
	SQL_NUMERIC_FUNCTIONS
	SQL_ODBC_INTERFACE_CONFORMANCE
	SQL_ODBC_VER
	SQL_OJ_CAPABILITIES
	SQL_ORDER_BY_COLUMNS_IN_SELECT
	SQL_PARAM_ARRAY_ROW_COUNTS
	SQL_PARAM_ARRAY_SELECTS
	SQL_PROCEDURES
	SQL_PROCEDURE_TERM
	SQL_QUOTED_IDENTIFIER_CASE
	SQL_ROW_UPDATES
	SQL_SCHEMA_TERM
	SQL_SCHEMA_USAGE
	SQL_SCROLL_OPTIONS
	SQL_SEARCH_PATTERN_ESCAPE
	SQL_SERVER_NAME
	SQL_SPECIAL_CHARACTERS
	SQL_SQL_CONFORMANCE
	SQL_STATIC_CURSOR_ATTRIBUTES1
	SQL_STATIC_CURSOR_ATTRIBUTES2
	SQL_STRING_FUNCTIONS
	SQL_SUBQUERIES
	SQL_SYSTEM_FUNCTIONS
	SQL_TABLE_TERM
	SQL_TIMEDATE_ADD_INTERVALS
	SQL_TIMEDATE_DIFF_INTERVALS
	SQL_TIMEDATE_FUNCTIONS
	SQL_TXN_CAPABLE
	SQL_TXN_ISOLATION_OPTION
	SQL_UNION
	SQL_USER_NAME
	SQL_XOPEN_CLI_YEAR
"""

def dump_hex_representation(val):
	test = 1
	components = []
	while test < 2**64:
		if val & test:
			components.append(str(hex(test)))
		test *= 2
	return "|".join(components)

main()
