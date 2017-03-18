import os

for i in range(1988, 2017):
	for j in range(1, 13):
		zipfile = "On_Time_On_Time_Performance_{0}_{1}.zip".format(i, j)
		if not os.path.exists(zipfile):
			url = "http://tsdata.bts.gov/PREZIP/" + file
			os.system("wget {0}".format(url))
		else:
			print "Skipping already present file", file
