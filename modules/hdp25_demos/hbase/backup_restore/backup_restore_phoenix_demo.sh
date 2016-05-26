#!/bin/sh

set -x

read -p "Setup some environment stuff"

# Create a directory where backups will get staged.
sudo -u hdfs hdfs dfs -mkdir -p /user/hbase
sudo -u hdfs hdfs dfs -chown hbase:hbase /user/hbase

# Allow HBase to run exports.
cd /vagrant/modules/hdp25_demos/hbase/backup_restore
sudo cp container-executor.cfg /etc/hadoop/hdp/container-executor.cfg
sudo systemctl restart hadoop-yarn-nodemanager
sudo systemctl restart hadoop-yarn-resourcemanager
# XXX: Something's wrong here
sudo -u hdfs hdfs dfs -chmod 777 /user/yarn/history
cd /home/vagrant

cat<<EOF>temp.sql
/* Some data to backup. */
drop table if exists test_data;
create table test_data (customer_id integer primary key, city varchar);
upsert into test_data values(1, 'Chicago');
upsert into test_data values(2, 'San Jose');
upsert into test_data values(3, 'New York');
upsert into test_data values(4, 'New York');

/* A secondary index on the data. */
CREATE INDEX my_index ON test_data (city) INCLUDE(customer_id);
EOF

read -p "Insert some data and index it"
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.sql

read -p "Query the data"
cat<<EOF>temp.sql
select * from test_data;
select * from my_index;
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.sql

read -p "Create the full backup to start"
sudo -u hdfs hdfs dfs -rmr /tmp/backup_incremental
sudo -u hbase hbase backup create full /tmp/backup_incremental
hdfs dfs -lsr /tmp/backup_incremental

read -p "Insert some more data"
cat<<EOF>temp.sql
upsert into test_data values(5, 'Chicago');
upsert into test_data values(6, 'Miami');
upsert into test_data values(7, 'Seattle');
upsert into test_data values(8, 'Chicago');
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.sql

read -p "Query the data"
cat<<EOF>temp.sql
select * from test_data;
select * from my_index;
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.sql

# Perform the incremental backup
read -p "Perform the incremental backup"
sudo -u hbase hbase backup create incremental /tmp/backup_incremental
hdfs dfs -lsr /tmp/backup_incremental

# Reset Phoenix completely.
read -p "Resetting Phoenix"
cat<<EOF>temp.sql
drop table test_data;
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.sql

cat<<EOF>temp.txt
disable 'SYSTEM:CATALOG'
disable 'SYSTEM:FUNCTION'
disable 'SYSTEM:SEQUENCE'
disable 'SYSTEM:STATS'
drop 'SYSTEM:CATALOG'
drop 'SYSTEM:FUNCTION'
drop 'SYSTEM:SEQUENCE'
drop 'SYSTEM:STATS'
EOF
hbase shell < temp.txt

read -p "Restore the full backup"
FULL_BACKUP_ID=$(hdfs dfs -ls /tmp/backup_incremental/ | head -2 | tail -1 | awk '{print $8}' | cut -d/ -f4)
INCR_BACKUP_ID=$(hdfs dfs -ls /tmp/backup_incremental/ | tail -1 | awk '{print $8}' | cut -d/ -f4)
sudo -u hbase hbase restore /tmp/backup_incremental $FULL_BACKUP_ID SYSTEM:CATALOG,SYSTEM:SEQUENCE,MY_INDEX,SYSTEM:FUNCTION,SYSTEM:STATS,TEST_DATA

read -p "Query the data (before the increment)"
cat<<EOF>temp.sql
select * from test_data;
select * from my_index;
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.sql

read -p "Restore the increment"
sudo -u hbase hbase restore /tmp/backup_incremental $INCR_BACKUP_ID SYSTEM:CATALOG,SYSTEM:SEQUENCE,MY_INDEX,SYSTEM:FUNCTION,SYSTEM:STATS,TEST_DATA -overwrite

read -p "Query the data again"
cat<<EOF>temp.sql
select * from test_data;
select * from my_index;
EOF
/usr/hdp/current/phoenix-client/bin/sqlline.py -f temp.sql
