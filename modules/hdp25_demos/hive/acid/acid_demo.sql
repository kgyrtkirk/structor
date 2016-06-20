!echo Table counts before we maintain data.;
!cat /vagrant/modules/hdp25_demos/hive/acid/count_tables.sql;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
source /vagrant/modules/hdp25_demos/hive/acid/count_tables.sql;
!echo Write to FIFO to continue;
!cat /tmp/fifo;

!echo Generating and staging update data;
!/vagrant/modules/hdp25_demos/hive/acid/update-tpch-data-demo.sh;

!echo Setup staging tables;
!cat /vagrant/modules/hdp25_demos/hive/acid/setup_staging.sql;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
source /vagrant/modules/hdp25_demos/hive/acid/setup_staging.sql;

!echo Do all the updates and deletes;
!cat /vagrant/modules/hdp25_demos/hive/acid/updates_deletes.sql;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
source /vagrant/modules/hdp25_demos/hive/acid/updates_deletes.sql;

!echo Table counts after we maintain data.;
!cat /vagrant/modules/hdp25_demos/hive/acid/count_tables.sql;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
source /vagrant/modules/hdp25_demos/hive/acid/count_tables.sql;
