#!/usr/bin/python

from bs4 import BeautifulSoup
import csv
import glob
import sys

features = {}

files = glob.glob("dag*.html")
for f in files:
	dag = f[0:-11]
	time = float(f[-10:-6]) / 100
	if dag not in features:
		features[dag] = {}
	fd = open(f)
	html = fd.read()
	soup = BeautifulSoup(html, 'html.parser')
	table = soup.find_all('table', { "class" : "detail-list" })
	for t in table:
		for row in soup.find_all('tr'):
			text = row.text.lower()
			if text.find("task") > -1 or text.find("vert") > -1:
				text = text.split()
				if not text[-1].isdigit():
					text.pop()
				value = text[-1]
				label = "_".join(text[0:-1])
				features[dag][label] = value
	if html.find("Loading") == -1:
		if "load_time" not in features[dag]:
			features[dag]["load_time"] = time

header = False
writer = csv.writer(sys.stdout)
dags = sorted(features.keys())
for dag in dags:
	hash = features[dag]
	if not header:
		keys = hash.keys()
		row = [ "dag" ]
		row.extend(keys)
		writer.writerow(row)
		header = True
	vals = hash.values()
	row = [ dag ]
	row.extend(vals)
	writer.writerow(row)
