#!/bin/sh

sudo mkdir -p /root/.ssh
sudo chmod 700 /root/.ssh
sudo ssh-keygen -f /root/.ssh/id_rsa -q -N ""
sudo cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
sudo ssh-keyscan -H $(hostname) >> /root/.ssh/known_hosts
sudo ssh-keyscan -H $(hostname -a) >> /root/.ssh/known_hosts
sudo ssh-keyscan -H localhost >> /root/.ssh/known_hosts
