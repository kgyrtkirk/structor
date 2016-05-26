#!/usr/bin/python

from faker import Factory
import random

faker = Factory.create()

for i in xrange(0, 500):
	ccn = faker.credit_card_number()
	l = len(ccn)
	if l == 12:
		ccn = "-".join([ccn[0:4], ccn[4:6], ccn[6:8], ccn[8:12]])
	if l == 13:
		ccn = "-".join([ccn[0:4], ccn[4:6], ccn[6:9], ccn[9:13]])
	if l == 14:
		ccn = "-".join([ccn[0:4], ccn[4:7], ccn[7:10], ccn[10:14]])
	if l == 15:
		ccn = "-".join([ccn[0:4], ccn[4:7], ccn[7:11], ccn[11:15]])
	if l == 16:
		ccn = "-".join([ccn[0:4], ccn[4:8], ccn[8:12], ccn[12:16]])
	preference = str(random.betavariate(0.5, 0.5))
	zip = faker.zipcode()
	zip = zip[0:3] + "00"
	account_data = [
		faker.first_name() + " " + faker.last_name(),
		faker.ssn(),
		ccn,
		zip,
		preference[0:5]
	]
	print "\001".join(account_data)
