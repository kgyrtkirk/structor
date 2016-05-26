# HDP 2.5 HBase demos
=======

Demos include:
* Incremental backup and restore.
* Phoenix Query Server and Python client.
* Namespace support.
* Date-tiered and FIFO compaction.

## Reproduce these demos for yourself:

```
# Install VirtualBox 5 or later.
# Install Vagrant 1.8.1 or later.
git clone https://github.com/cartershanklin/structor
cd structor
ln -s profiles/hdp250-hbase.profile current.profile
vagrant up
# To log in, vagrant ssh hdp250-hbase
# Demos available in /vagrant/modules/hdp25_demos/hbase/*
```
