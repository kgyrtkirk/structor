#!/bin/sh

chmod 755 /home/vagrant
sudo mkdir -p /var/log/hadoop/hive
sudo chown hive:hadoop /var/log/hadoop/hive

if [ ! -d /usr/local/share/maven ]; then
	/vagrant/modules/maven/files/install_maven_manually.sh
	export PATH=/usr/local/share/maven/bin:$PATH
fi

sudo yum install -y git

# Build Hive master.
cd ~
git clone https://github.com/apache/hive
cd hive
git pull
mvn clean package -DskipTests -Pdist

# Install and configure.
rm -rf ~/hivedist
mkdir ~/hivedist
cd ~/hivedist
mv ~/hive/packaging/target/apache-hive-*-bin.tar.gz .
tar -zxf apache-hive-*-bin.tar.gz
ln -s apache-hive-*-bin hive
cd hive
cp bin/hive bin/hive.distro
cp /usr/bin/hive2 bin/hive
cp /etc/hive2/conf/hive-site.xml conf/

# Stop and disable Metastore and HS2
sudo systemctl stop hive-metastore
sudo systemctl stop hive-server2
sudo systemctl stop hive2-server2
sudo systemctl disable hive-metastore
sudo systemctl disable hive-server2
sudo systemctl disable hive2-server2

# For the environment.
cat /vagrant/modules/hive_trunk/files/.bash_profile >> ~/.bash_profile
source /vagrant/modules/hive_trunk/files/.bash_profile

# Upgrade the metastore DB.
schematool -dbType mysql -upgradeSchema
