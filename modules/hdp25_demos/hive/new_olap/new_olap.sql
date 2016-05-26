use tpch_bin_flat_orc_2;

!echo Multi Order By;
!cat /vagrant/modules/hdp25_demos/hive/new_olap/multi_order_by.sql;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
source /vagrant/modules/hdp25_demos/hive/new_olap/multi_order_by.sql;

!echo Multi Partition By;
!cat /vagrant/modules/hdp25_demos/hive/new_olap/multi_partition_by.sql;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
source /vagrant/modules/hdp25_demos/hive/new_olap/multi_partition_by.sql;

!echo Order by a UDF;
!cat /vagrant/modules/hdp25_demos/hive/new_olap/order_by_udf.sql;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
source /vagrant/modules/hdp25_demos/hive/new_olap/order_by_udf.sql;

!echo Sort nulls last;
!cat /vagrant/modules/hdp25_demos/hive/new_olap/nulls_first_last.sql;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
source /vagrant/modules/hdp25_demos/hive/new_olap/nulls_first_last.sql;
