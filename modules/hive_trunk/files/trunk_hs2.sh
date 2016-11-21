#!/bin/sh

# Stop and disable the old servers.
sudo systemctl stop hive-server2
sudo systemctl stop hive2-server2
sudo systemctl stop hive-metastore
sudo systemctl disable hive-server2
sudo systemctl disable hive2-server2
sudo systemctl disable hive-metastore

# Upgrade the schema.
export HIVE_CONF_DIR=/home/vagrant/hivedist/hive/conf
export HIVE_HOME=/home/vagrant/hivedist/hive
cd ~/hivedist/hive
bin/schematool -dbType mysql -upgradeSchema

# Put new control scripts in place.
sudo cp /vagrant/modules/hive_trunk/files/hive-metastore.service /etc/systemd/system
sudo cp /vagrant/modules/hive_trunk/files/hive2-server2.service /etc/systemd/system
sudo mkdir -p /etc/systemd/system/hive2-server2.service.d
sudo cp /vagrant/modules/hive_trunk/files/default.conf /etc/systemd/system/hive2-server2.service.d
sudo cp /vagrant/modules/hive_trunk/files/default.conf /etc/systemd/system/hive-metastore.service.d

# Re-enable and start the new servers.
sudo systemctl enable hive-metastore
sudo systemctl enable hive2-server2
sudo systemctl start hive-metastore
sudo systemctl start hive2-server2
