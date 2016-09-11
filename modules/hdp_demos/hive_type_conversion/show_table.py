#!/usr/bin/python

# Flask app to render a CSV file as a table using Google Charts.
from flask import Flask, flash, redirect, render_template, request, session, abort
import csv
import os

tmpl_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')
app = Flask(__name__, template_folder=tmpl_dir)

@app.route("/")
def dashboard():
	# Get the Version.
	with open("version.txt") as fd:
		version = fd.read()
		fields = version.split(".")
		version = ".".join(fields[0:3])

	# Read the CSV.
	with open("conversion.csv") as fd:
		reader = csv.reader(fd)
		header = reader.next()
		rows = []
		for line in reader:
			rows.append(",".join([ '"{0}"'.format(x) for x in line ]))

	# Render the charts.
	return render_template('conversions.html', **locals())

if __name__ == "__main__":
	app.debug = True
	app.run(host= '0.0.0.0')
