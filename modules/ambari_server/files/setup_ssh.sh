#!/bin/sh

mkdir -p /root/.ssh
chmod 700 /root/.ssh
ssh-keygen -f /root/.ssh/id_rsa -q -N ""
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
ssh-keyscan -H $(hostname) >> /root/.ssh/known_hosts
ssh-keyscan -H $(hostname -a) >> /root/.ssh/known_hosts
ssh-keyscan -H localhost >> /root/.ssh/known_hosts
