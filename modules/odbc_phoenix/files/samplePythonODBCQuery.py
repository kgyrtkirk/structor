import pyodbc
import time

cnxn = pyodbc.connect('DSN=Hortonworks Phoenix ODBC DSN', autocommit=True)
cursor = cnxn.cursor()

print "Paging through the system catalog"
offset = 0
rows = 10
while rows == 10:
	statement = "select * from system.catalog offset {0} fetch first 10 rows only".format(offset)
	print "Selecting catalog rows starting from offset", offset
	print statement
	time.sleep(2)
	cursor.execute(statement)
	rows = 0
	row = cursor.fetchone()
	while row:
		print row[1:4]
		row = cursor.fetchone()
		rows += 1
	offset += 10
