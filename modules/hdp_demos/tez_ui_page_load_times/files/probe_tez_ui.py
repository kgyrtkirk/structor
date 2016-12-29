import dryscrape
import getopt
import os
import sys
import time

def main():
	if 'linux' in sys.platform:
		# start xvfb in case no X is running. Make sure xvfb 
		# is installed, otherwise this won't work!
		dryscrape.start_xvfb()

	try:
		opts, args = getopt.getopt(sys.argv[1:], "s:")
	except getopt.GetoptError as err:
		print str(err)
		print "probe_tez_ui.py -s UI endpoint"
		sys.exit(2)

	ui_server = None
	for o, a in opts:
		if o == "-s":
			ui_server = a
	if ui_server == None:
		assert False, "probe_tez_ui.py -s UI endpoint"

	suffix = "/tez-ui/#/?rowCount=100"
	url = "http://{0}/{1}".format(ui_server, suffix)
	print "Probing", url
	sess = dryscrape.Session(base_url = url)

	sess.visit(suffix)
	time.sleep(10.0)

	# Extract DAG links.
	targets = []
	for link in sess.xpath('//a[@href]'):
		link = link['href']
		if link.startswith("#/dag/"):
			targets.append(link)

	for link in targets:
		id = link.split('/')[-1]
		print(link)
		sess.visit(link)
		cumulative = 0
		while cumulative <= 20:
			sleep_time = 0.25
			cumulative += sleep_time
			print "Sleeping ({0})".format(cumulative)
			time.sleep(sleep_time)
			new_file_text = "{0}_{1:04d}s.html".format(id, int(cumulative*100))
			text = sess.body().encode('utf-8')
			fd = open(new_file_text, "w")
			fd.write(text)
			fd.close()
			if text.find("Loading") == -1:
				break

main()
