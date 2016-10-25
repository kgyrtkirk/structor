#!/usr/bin/python

from kafka import KafkaProducer
from loremipsum import get_sentence

import random
import time

producer = KafkaProducer(bootstrap_servers="localhost:9092")
while 1:
	print "Writing a sentence to random_strings."
	producer.send("random_strings", get_sentence().encode('utf-16be'))
	time.sleep(1 + 5*random.random())
