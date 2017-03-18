#!/home/vagrant/jython/bin/jython

# export CLASSPATH=/usr/hdp/2.5.3.0-37/hive2/jdbc/hive-jdbc-2.1.0.2.5.3.0-37-standalone.jar:/usr/hdp/2.5.3.0-37/hadoop/hadoop-common-2.7.3.2.5.3.0-37.jar

import sys

from java.lang import Class
from java.sql import DriverManager, SQLException, DatabaseMetaData

DATABASE = "tpch_orc_bin_flat_orc_2"
JDBC_URL = "jdbc:sqlite:%s" % DATABASE
JDBC_URL = "jdbc:hive2://localhost:10000/%s" % DATABASE
JDBC_DRIVER = "org.apache.hive.jdbc.HiveDriver"

def main():
	dbConn = getConnection(JDBC_URL, JDBC_DRIVER)
	dm = dbConn.getMetaData()
	schema = "tpch_bin_flat_orc_2"
	for table in ['customer', 'lineitem', 'nation', 'orders', 'part']:
		#rs = dm.getPrimaryKeys(None, schema, table)
		#while rs.next():
		#	col = rs.getString("COLUMN_NAME")
		#	print "Primary: {0}: {1}".format(table, col)
		rs = dm.getImportedKeys(None, schema, table)
		while rs.next():
			col = rs.getString("COLUMN_NAME")
			print "Imported: {0}: {1}".format(table, col)
		rs = dm.getExportedKeys(None, schema, table)
		while rs.next():
			col = rs.getString("COLUMN_NAME")
			print "Imported: {0}: {1}".format(table, col)

	dbConn.close()
	sys.exit(0)

def getConnection(jdbc_url, driverName):
	try:
		Class.forName(driverName).newInstance()
	except Exception, msg:
		print msg
		sys.exit(-1)

	try:
		dbConn = DriverManager.getConnection(jdbc_url)
	except SQLException, msg:
		print msg
		sys.exit(-1)

	return dbConn

if __name__ == '__main__':
	main()
