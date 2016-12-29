from sklearn import linear_model

import csv
fd = open("features.csv")
reader = csv.reader(fd)
header = next(reader)
print ", ".join(header[4:7])
records = []
lhs = []
for line in reader:
	this_lhs = float(line[-2])
	record = [ int(x) for x in line[4:7] ]
	print ", ".join([ str(x) for x in record ]), ",", this_lhs
	lhs.append(this_lhs)
	records.append(record)

clf = linear_model.LinearRegression()
clf.fit(records, lhs)
print clf.coef_
print clf.intercept_
