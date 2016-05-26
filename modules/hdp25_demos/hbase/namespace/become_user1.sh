#!/bin/sh

cd /home/vagrant

HOST=$(hostname)

kdestroy
kinit -k -t user1.keytab user1/$HOST@EXAMPLE.COM
