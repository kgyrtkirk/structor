#!/bin/sh

maven_version="3.3.9"
maven_base="apache-maven-$maven_version"
maven_bin="$maven_base-bin.tar.gz"
maven_dist="http://mirrors.ibiblio.org/apache/maven/maven-3/$maven_version/binaries/$maven_bin"
m2_home="/usr/local/share/$maven_base"

if [ ! -f /usr/local/share/maven/bin/mvn ] ; then
	cd /tmp
	curl -C - -O $maven_dist
	sudo tar -C /usr/local/share -xvf $maven_bin
	sudo ln -s /usr/local/share/$maven_base /usr/local/share/maven
	sudo cp /vagrant/modules/maven/files/maven.sh /etc/profile.d/maven.sh
	cp -r /vagrant/.m2 /home/vagrant
	chmod -R 775 /home/vagrant/.m2
fi
