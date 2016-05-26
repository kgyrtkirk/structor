# HDP 2.5 Hive demos
=======

Demos include:
* Simplified beeline usage.
* Primary / Foreign Key Support.
* Other new SQL features.
* Stored Procedure support.
* LLAP.

## Reproduce these demos for yourself:

```
# Install VirtualBox 5 or later.
# Install Vagrant 1.8.1 or later.
git clone https://github.com/cartershanklin/structor
cd structor
ln -s profiles/llap.profile current.profile
vagrant up
# To log in, vagrant ssh llap
# Demos available in /vagrant/modules/hdp25_demos/hive/*
```
