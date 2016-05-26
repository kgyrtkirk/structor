import pyodbc

cnxn = pyodbc.connect('DSN=Hortonworks Phoenix ODBC DSN', autocommit=True)
cursor = cnxn.cursor()

print "Number of records in catalog"
cursor.execute("select count(*) from system.catalog")
row = cursor.fetchone()
if row:
	print row
