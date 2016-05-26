#!/bin/sh

set -x

cd /home/vagrant

read -p "Creating user1 and user2 users"
sudo adduser user1
sudo adduser user2

# Get rid of old keytabs.
sudo rm -f user1.keytab user2.keytab

# Create keytabs for these users.
HOST=$(hostname)
sudo kadmin.local<<EOF
addprinc -randkey user1/$HOST@EXAMPLE.COM
xst -norandkey -k user1.keytab user1/$HOST@EXAMPLE.COM
addprinc -randkey user2/$HOST@EXAMPLE.COM
xst -norandkey -k user2.keytab user2/$HOST@EXAMPLE.COM
EOF

sudo chmod 755 user1.keytab user2.keytab

kdestroy
echo vagrant | kinit

read -p "Creating Phoenix schemas and tables."
cat<<EOF>temp.txt
create schema if not exists app_1;
create schema if not exists app_2;
drop table if exists app_1.main;
drop table if exists app_2.main;
create table app_1.main (id integer primary key);
create table app_2.main (id integer primary key);
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.txt

read -p "Applying permissions to schemas."
cat<<EOF>temp.txt
grant 'user1', 'RC', 'SYSTEM:CATALOG'
grant 'user1', 'C', 'SYSTEM:SEQUENCE'
grant 'user1', 'C', 'SYSTEM:STATS'
grant 'user1', 'C', 'SYSTEM:FUNCTION'
grant 'user2', 'RC', 'SYSTEM:CATALOG'
grant 'user2', 'C', 'SYSTEM:SEQUENCE'
grant 'user2', 'C', 'SYSTEM:STATS'
grant 'user2', 'C', 'SYSTEM:FUNCTION'
grant 'user1', 'RWXCA', '@APP_1'
grant 'user2', 'RWXCA', '@APP_2'
grant 'user2', 'R', '@APP_1'
EOF
hbase shell < temp.txt

read -p "Become user 1"
/vagrant/modules/hdp25_demos/hbase/namespace/become_user1.sh

read -p "Insert some data into app_1"
cat<<EOF>temp.txt
upsert into app_1.main values (1);
select * from app_1.main;
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.txt

read -p "Attempt to access app_2"
cat<<EOF>temp.txt
select * from app_2.main;
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.txt

read -p "Become user 2"
/vagrant/modules/hdp25_demos/hbase/namespace/become_user2.sh

read -p "Insert some data into app_2"
cat<<EOF>temp.txt
upsert into app_2.main values (2);
select * from app_2.main;
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.txt

read -p "Read from app_1"
cat<<EOF>temp.txt
select * from app_1.main;
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.txt

read -p "Attempt to insert into app_1"
cat<<EOF>temp.txt
upsert into app_1.main values (3);
select * from app_1.main;
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.txt

