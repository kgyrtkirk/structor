#!/bin/sh

cd /home/vagrant
wget -O jython-installer-2.7.0.jar "http://search.maven.org/remotecontent?filepath=org/python/jython-installer/2.7.0/jython-installer-2.7.0.jar"
java -jar jython-installer-2.7.0.jar -s -d jython
