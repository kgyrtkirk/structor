create database if not exists tpch_2_phoenix;
use tpch_2_phoenix;

drop table if exists nation;
create table nation(N_NATIONKEY INT, N_NAME CHAR(25), N_REGIONKEY INT, N_COMMENT VARCHAR(152))
stored by "org.apache.phoenix.hive.PhoenixStorageHandler"
TBLPROPERTIES(
  'phoenix.table.name'='nation',
  'phoenix.zookeeper.znode.parent'='/hbase',
  'phoenix.zookeeper.quorum'='hdp250-hbase-nonsecure:2181',
  'phoenix.rowkeys'='n_nationkey'
);

drop table if exists region;
CREATE TABLE REGION ( R_REGIONKEY INT, R_NAME CHAR(25), R_COMMENT VARCHAR(152))
stored by "org.apache.phoenix.hive.PhoenixStorageHandler"
TBLPROPERTIES(
  'phoenix.table.name'='region',
  'phoenix.zookeeper.znode.parent'='/hbase',
  'phoenix.zookeeper.quorum'='hdp250-hbase-nonsecure:2181',
  'phoenix.rowkeys'='r_regionkey'
);

drop table if exists part;
CREATE TABLE PART ( P_PARTKEY INT, P_NAME VARCHAR(55), P_MFGR CHAR(25), P_BRAND CHAR(10), P_TYPE VARCHAR(25), P_SIZE INT,
  P_CONTAINER CHAR(10), P_RETAILPRICE DECIMAL(15,2), P_COMMENT VARCHAR(23) )
stored by "org.apache.phoenix.hive.PhoenixStorageHandler"
TBLPROPERTIES(
  'phoenix.table.name'='part',
  'phoenix.zookeeper.znode.parent'='/hbase',
  'phoenix.zookeeper.quorum'='hdp250-hbase-nonsecure:2181',
  'phoenix.rowkeys'='p_partkey'
);

drop table if exists supplier;
CREATE TABLE SUPPLIER ( S_SUPPKEY INT, S_NAME CHAR(25), S_ADDRESS VARCHAR(40), S_NATIONKEY INT, S_PHONE CHAR(15),
  S_ACCTBAL DECIMAL(15,2), S_COMMENT VARCHAR(101))
stored by "org.apache.phoenix.hive.PhoenixStorageHandler"
TBLPROPERTIES(
  'phoenix.table.name'='supplier',
  'phoenix.zookeeper.znode.parent'='/hbase',
  'phoenix.zookeeper.quorum'='hdp250-hbase-nonsecure:2181',
  'phoenix.rowkeys'='s_suppkey'
);

drop table if exists partsupp;
CREATE TABLE PARTSUPP ( PS_PARTKEY INT, PS_SUPPKEY INT, PS_AVAILQTY INT, PS_SUPPLYCOST DECIMAL(15,2) ,
  PS_COMMENT VARCHAR(199) )
stored by "org.apache.phoenix.hive.PhoenixStorageHandler"
TBLPROPERTIES(
  'phoenix.table.name'='partsupp',
  'phoenix.zookeeper.znode.parent'='/hbase',
  'phoenix.zookeeper.quorum'='hdp250-hbase-nonsecure:2181',
  'phoenix.rowkeys'='ps_partkey'
);

drop table if exists customer;
CREATE TABLE CUSTOMER ( C_CUSTKEY INT, C_NAME VARCHAR(25), C_ADDRESS VARCHAR(40), C_NATIONKEY INT, C_PHONE CHAR(15),
  C_ACCTBAL DECIMAL(15,2) , C_MKTSEGMENT CHAR(10), C_COMMENT VARCHAR(117))
stored by "org.apache.phoenix.hive.PhoenixStorageHandler"
TBLPROPERTIES(
  'phoenix.table.name'='customer',
  'phoenix.zookeeper.znode.parent'='/hbase',
  'phoenix.zookeeper.quorum'='hdp250-hbase-nonsecure:2181',
  'phoenix.rowkeys'='c_custkey'
);

drop table if exists orders;
CREATE TABLE ORDERS ( O_ORDERKEY INT, O_CUSTKEY INT, O_ORDERSTATUS CHAR(1), O_TOTALPRICE DECIMAL(15,2), O_ORDERDATE DATE,
  O_ORDERPRIORITY CHAR(15), O_CLERK CHAR(15), O_SHIPPRIORITY INT, O_COMMENT VARCHAR(79))
stored by "org.apache.phoenix.hive.PhoenixStorageHandler"
TBLPROPERTIES(
  'phoenix.table.name'='orders',
  'phoenix.zookeeper.znode.parent'='/hbase',
  'phoenix.zookeeper.quorum'='hdp250-hbase-nonsecure:2181',
  'phoenix.rowkeys'='o_orderkey'
);

drop table if exists lineitem;
CREATE TABLE LINEITEM ( L_ORDERKEY INT, L_PARTKEY INT, L_SUPPKEY INT, L_LINENUMBER INT, L_QUANTITY DECIMAL(15,2),
  L_EXTENDEDPRICE DECIMAL(15,2), L_DISCOUNT DECIMAL(15,2), L_TAX DECIMAL(15,2), L_RETURNFLAG CHAR(1), L_LINESTATUS CHAR(1),
  L_SHIPDATE DATE, L_COMMITDATE DATE, L_RECEIPTDATE DATE, L_SHIPINSTRUCT CHAR(25), L_SHIPMODE CHAR(10), L_COMMENT VARCHAR(44))
stored by "org.apache.phoenix.hive.PhoenixStorageHandler"
TBLPROPERTIES(
  'phoenix.table.name'='lineitem',
  'phoenix.zookeeper.znode.parent'='/hbase',
  'phoenix.zookeeper.quorum'='hdp250-hbase-nonsecure:2181',
  'phoenix.rowkeys'='l_orderkey'
);


