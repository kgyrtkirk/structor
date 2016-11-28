create database if not exists accumulating_snapshot;
create database accumulating_snapshot;
use accumulating_snapshot;

drop table if exists order_fulfillment;
drop table if exists customer;
drop table if exists product;

-- Load the standard date dimension.
source /OneDrive/Documents/SQLDemos/DateDimension/load_hive.sql;

create table order_fulfillment (
  order_date_sk integer,
  backlog_date_sk integer,
  rtm_date_sk integer,
  finished_inv_date_sk integer,
  ship_date_sk integer,
  customer_key integer,
  product_key integer,
  order_number integer,
  order_to_mfg_lag integer,
  mfg_to_inv_lag integer,
  inv_to_ship_lag integer,
  order_to_ship_lag integer
)
CLUSTERED BY (order_number) INTO 2 BUCKETS STORED AS ORC TBLPROPERTIES ("transactional"="true");

create table product (
  product_key integer,
  list_price float
);

create table customer (
  customer_key integer
);

insert into product values
(1, 1.5), (2, 2.5), (3, 3.3), (4, 4.6), (5, 5.8);

insert into customer values
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

drop table if exists op_system_snapshot;
create table op_system_snapshot (
  op_order_number integer,
  op_customer integer,
  op_product integer,
  op_order_date date,
  op_backlog_date date,
  op_rtm_date date,
  op_finished_inv_date date,
  op_ship_date date
);
insert into op_system_snapshot values
(1, 1, 1, "2012-03-01", "2012-03-01", "2012-03-03", "2012-03-05", "2012-03-08"),
(2, 7, 2, "2012-03-01", "2012-03-01", "2012-03-04", "2012-03-07", null),
(3, 4, 3, "2012-03-02", "2012-03-02", "2012-03-06", "2012-03-09", null),
(4, 3, 4, "2012-03-07", "2012-03-07", null, null, null),
(5, 2, 3, "2012-03-09", "2012-03-09", null, null, null);

merge into order_fulfillment
using (
  with sks_substituted as (
  select
    op_order_number, op_customer, op_product,
    d1.id as op_order_date_sk, d2.id as op_backlog_date_sk, d3.id as op_rtm_date_sk,
    d4.id as op_finished_inv_date_sk, d5.id op_ship_date_sk,
    extract(day from op_rtm_date          - op_order_date)        as op_order_to_mfg_lag,
    extract(day from op_finished_inv_date - op_rtm_date)          as op_mfg_to_inv_lag,
    extract(day from op_ship_date         - op_finished_inv_date) as op_inv_to_ship_lag,
    extract(day from op_ship_date         - op_order_date)        as op_order_to_ship_lag
  from
    op_system_snapshot join date_dim d1 on op_system_snapshot.op_order_date <=> d1.cal_date
    join date_dim d2 on op_system_snapshot.op_backlog_date <=> d2.cal_date
    join date_dim d3 on op_system_snapshot.op_rtm_date <=> d3.cal_date
    join date_dim d4 on op_system_snapshot.op_finished_inv_date <=> d4.cal_date
    join date_dim d5 on op_system_snapshot.op_ship_date <=> d5.cal_date )
  select
    *,
    crc32(concat_ws("X", cast(op_order_number as string),
      cast(op_order_date_sk as string), cast(op_backlog_date_sk as string),
      cast(op_rtm_date_sk as string), cast(op_finished_inv_date_sk as string),
      cast(op_ship_date_sk as string))) as op_crc,
    crc32(concat_ws("X", cast(order_number as string),
      cast(order_date_sk as string), cast(backlog_date_sk as string),
      cast(rtm_date_sk as string), cast(finished_inv_date_sk as string),
      cast(ship_date_sk as string))) as dw_crc
  from
    sks_substituted left join order_fulfillment on sks_substituted.op_order_number = order_fulfillment.order_number
) sub
on sub.op_order_number = order_fulfillment.order_number
when matched and op_crc <> dw_crc
then update set
  order_date_sk = op_order_date_sk, backlog_date_sk = op_backlog_date_sk, rtm_date_sk = op_rtm_date_sk,
  finished_inv_date_sk = op_finished_inv_date_sk, ship_date_sk = op_ship_date_sk,
  order_to_mfg_lag = op_order_to_mfg_lag, mfg_to_inv_lag = op_mfg_to_inv_lag, inv_to_ship_lag = op_inv_to_ship_lag,
  order_to_ship_lag = op_order_to_ship_lag
when not matched
then insert values
  (op_order_date_sk, op_backlog_date_sk, op_rtm_date_sk, op_finished_inv_date_sk, op_ship_date_sk,
  op_customer, op_product, op_order_number, op_order_to_mfg_lag, op_mfg_to_inv_lag, op_inv_to_ship_lag, op_order_to_ship_lag);
select * from order_fulfillment order by order_number;

-- Fast forward 5 days and get a refreshed dump from the operational system.
drop table if exists op_system_snapshot;
create table op_system_snapshot (
  op_order_number integer,
  op_customer integer,
  op_product integer,
  op_order_date date,
  op_backlog_date date,
  op_rtm_date date,
  op_finished_inv_date date,
  op_ship_date date
);
insert into op_system_snapshot values
(1, 1, 1, "2012-03-01", "2012-03-01", "2012-03-03", "2012-03-05", "2012-03-08"),
(2, 7, 2, "2012-03-01", "2012-03-01", "2012-03-04", "2012-03-07", "2012-03-11"),
(3, 4, 3, "2012-03-02", "2012-03-02", "2012-03-06", "2012-03-09", "2012-03-14"),
(4, 3, 4, "2012-03-07", "2012-03-07", "2012-03-11", "2012-03-14", null),
(5, 2, 3, "2012-03-09", "2012-03-09", "2012-03-13", null, null),
(6, 5, 1, "2012-03-10", "2012-03-10", "2012-03-12", "2012-03-14", null),
(7, 6, 2, "2012-03-11", "2012-03-10", "2012-03-13", null, null);

-- Now re-do the merge.
merge into order_fulfillment
using (
  with sks_substituted as (
  select
    op_order_number, op_customer, op_product,
    d1.id as op_order_date_sk, d2.id as op_backlog_date_sk, d3.id as op_rtm_date_sk,
    d4.id as op_finished_inv_date_sk, d5.id op_ship_date_sk,
    extract(day from op_rtm_date          - op_order_date)        as op_order_to_mfg_lag,
    extract(day from op_finished_inv_date - op_rtm_date)          as op_mfg_to_inv_lag,
    extract(day from op_ship_date         - op_finished_inv_date) as op_inv_to_ship_lag,
    extract(day from op_ship_date         - op_order_date)        as op_order_to_ship_lag
  from
    op_system_snapshot join date_dim d1 on op_system_snapshot.op_order_date <=> d1.cal_date
    join date_dim d2 on op_system_snapshot.op_backlog_date <=> d2.cal_date
    join date_dim d3 on op_system_snapshot.op_rtm_date <=> d3.cal_date
    join date_dim d4 on op_system_snapshot.op_finished_inv_date <=> d4.cal_date
    join date_dim d5 on op_system_snapshot.op_ship_date <=> d5.cal_date )
  select
    *,
    crc32(concat_ws("X", cast(op_order_number as string),
      cast(op_order_date_sk as string), cast(op_backlog_date_sk as string),
      cast(op_rtm_date_sk as string), cast(op_finished_inv_date_sk as string),
      cast(op_ship_date_sk as string))) as op_crc,
    crc32(concat_ws("X", cast(order_number as string),
      cast(order_date_sk as string), cast(backlog_date_sk as string),
      cast(rtm_date_sk as string), cast(finished_inv_date_sk as string),
      cast(ship_date_sk as string))) as dw_crc
  from
    sks_substituted left join order_fulfillment on sks_substituted.op_order_number = order_fulfillment.order_number
) sub
on sub.op_order_number = order_fulfillment.order_number
when matched and op_crc <> dw_crc
then update set
  order_date_sk = op_order_date_sk, backlog_date_sk = op_backlog_date_sk, rtm_date_sk = op_rtm_date_sk,
  finished_inv_date_sk = op_finished_inv_date_sk, ship_date_sk = op_ship_date_sk,
  order_to_mfg_lag = op_order_to_mfg_lag, mfg_to_inv_lag = op_mfg_to_inv_lag, inv_to_ship_lag = op_inv_to_ship_lag,
  order_to_ship_lag = op_order_to_ship_lag
when not matched
then insert values
  (op_order_date_sk, op_backlog_date_sk, op_rtm_date_sk, op_finished_inv_date_sk, op_ship_date_sk,
  op_customer, op_product, op_order_number, op_order_to_mfg_lag, op_mfg_to_inv_lag, op_inv_to_ship_lag, op_order_to_ship_lag);
select * from order_fulfillment order by order_number;
