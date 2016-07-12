#!/usr/bin/python

num_splits = 8
num_lines = sum(1 for line in open("data.csv"))
block_size = int(num_lines / num_splits)
slop = num_lines - (num_splits * block_size)
sizes = [ block_size ] * num_splits
sizes[0] = sizes[0] + slop
print sizes

j=0
with open("data.csv") as fd:
	for s in sizes:
		out = open("split.{0}.csv".format(j), "w")
		j += 1
		for i in xrange(0, s):
			out.write(fd.next())
