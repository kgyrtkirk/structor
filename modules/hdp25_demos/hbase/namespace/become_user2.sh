#!/bin/sh

cd /home/vagrant

HOST=$(hostname)

kdestroy
kinit -k -t user2.keytab user2/$HOST@EXAMPLE.COM
