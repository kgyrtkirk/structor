#!/bin/sh

cd /tmp
curl -O https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm
sudo yum install -y pgdg-redhat96-9.6-3.noarch.rpm
sudo yum erase -y postgresql postgresql-server
sudo yum install -y postgresql96-server
sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb
# sudo cp /vagrant/modules/postgres_server/files/pg_hba.conf
sudo systemctl enable postgresql-9.6.service
sudo systemctl start postgresql-9.6.service
sudo -u postgres psql -c "CREATE USER vagrant WITH SUPERUSER PASSWORD 'vagrant';"
sudo -u postgres createdb vagrant
