drop database if exists citydata cascade;
create database citydata;
use citydata;

!sudo -u hdfs hdfs dfs -rmr /apps/hive/warehouse/citydata.db;
!sudo -u hdfs hdfs dfs -copyFromLocal -f citydata.db /apps/hive/warehouse;
!sudo -u hdfs hdfs dfs -chown -R vagrant:hadoop /apps/hive/warehouse/citydata.db;
!sudo -u hdfs hdfs dfs -chmod -R 775 /apps/hive/warehouse/citydata.db;

create table citydata (
  id int,
  name string
) partitioned by (load_date string, runid string);
msck repair table citydata;
