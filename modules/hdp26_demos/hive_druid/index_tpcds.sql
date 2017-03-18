set hive.druid.metadata.username=druid;
set hive.druid.metadata.password=vagrant;
set hive.druid.metadata.uri=jdbc:mysql://druid.example.com/druid;
set hive.druid.indexer.partition.size.max=1000000;
set hive.druid.indexer.memory.rownum.max=100000;
set hive.druid.broker.address.default=druid.example.com:8082;
set hive.druid.coordinator.address.default=druid.example.com:8081;
set hive.tez.container.size=1024;
set hive.druid.passiveWaitTimeMs=180000;

CREATE TABLE tpcds_store_sales_sold_time_day
STORED BY 'org.apache.hadoop.hive.druid.DruidStorageHandler'
TBLPROPERTIES (
  "druid.datasource" = "tpcds_store_sales_sold_time_day",
  "druid.segment.granularity" = "MONTH",
  "druid.query.granularity" = "DAY")
AS
SELECT
  CAST(d_date AS TIMESTAMP) AS `__time`,
  cast(i_manufact_id as STRING) i_manufact_id,
  cast(i_manager_id as STRING) i_manager_id,
  cast(i_item_desc as string) i_item_desc,
  cast(i_category_id AS STRING) i_category_id,
  cast(i_category as string) i_category,
  cast(i_class as string) i_class,
  CAST(i_item_id AS STRING) i_item_id,
  CAST(item.i_brand_id AS STRING) i_brand_id,
  cast(item.i_brand as string) i_brand,
  CAST(ss_customer_sk AS STRING) ss_customer_sk,
  CAST(ss_store_sk AS STRING) ss_store_sk,
  i_current_price, ss_ext_sales_price, ss_quantity, ss_sales_price
FROM
  tpcds_real_bin_partitioned_orc_2.store_sales,
  tpcds_real_bin_partitioned_orc_2.item,
  tpcds_real_bin_partitioned_orc_2.date_dim
where
  store_sales.ss_item_sk = item.i_item_sk and
  store_sales.ss_sold_date_sk = date_dim.d_date_sk;
