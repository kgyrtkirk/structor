from bs4 import BeautifulSoup
import csv
import requests
import sys

host = sys.argv[1]
base = "http://{0}:10002".format(host)
endpoint = base + "/hiveserver2.jsp"
r = requests.get(endpoint)
soup = BeautifulSoup(r.text, "html5lib")
links = soup.find_all('a')
queries = {}
id = 0
for l in links:
	href = l['href']
	if href.startswith("/query_page"):
		url = base + href + "#perfLogging"
		drilldown = requests.get(url)
		soup = BeautifulSoup(drilldown.text, "html5lib")
		tds = soup.find_all("td")
		query = tds[3]
		queries[id] = {}
		queries[id]["query"] = query.string
		for i in xrange(25, len(tds), 2):
			[key, value] = tds[i:i+2]
			queries[id][key.string] = value.string
		id += 1

# Get the keys
keyset = set()
for q in queries:
	keyset = keyset.union(queries[q].keys())

# Output.
writer = csv.writer(sys.stdout)

# The header
headers = ["id"]
headers.extend([x for x in keyset])
writer.writerow(headers)

# The values
for q in queries:
	query = queries[q]
	record = [q]
	for v in keyset:
		if v in query:
			record.append(query[v])
		else:
			record.append("")
	writer.writerow(record)
