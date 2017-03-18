-- Query in Hive against TPC-DS.
select
  dt.d_year,
  item.i_category_id,
  item.i_category,
  sum(ss_ext_sales_price) as s
from
  tpcds_bin_partitioned_orc_2.date_dim dt,
  tpcds_bin_partitioned_orc_2.store_sales,
  tpcds_bin_partitioned_orc_2.item
where
  dt.d_date_sk = store_sales.ss_sold_date_sk
  and store_sales.ss_item_sk = item.i_item_sk
  and dt.d_year between 1998 and 2002
group by
  dt.d_year,
  item.i_category_id,
  item.i_category;

-- Equivalent query in Druid
select
  floor_year(`__time`) d_year,
  i_category_id,
  i_category,
  sum(ss_ext_sales_price) as s
from
  tpcds_store_sales_sold_time_day3
where
  `__time` >= cast("1998-01-01" as date) and `__time` <= cast("2002-12-31" as date)
group by
  floor_year(`__time`),
  i_category_id,
  i_category;
