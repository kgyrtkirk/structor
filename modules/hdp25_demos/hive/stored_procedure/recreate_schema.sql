drop database if exists citydata cascade;
create database citydata;
use citydata;

!sudo -u hdfs hdfs dfs -copyFromLocal citydata.db /apps/hive/warehouse;
!sudo -u hdfs hdfs dfs -chown -R vagrant:vagrant /apps/hive/warehouse/citydata.db;

create table citydata (
  id int,
  name string
) partitioned by (load_date string, runid string);
msck repair table citydata;
