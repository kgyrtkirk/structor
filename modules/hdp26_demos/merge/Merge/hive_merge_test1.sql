drop database if exists merge_test cascade;
create database merge_test;
use merge_test;

-- Only needed for current trunk builds.
set hive.mapred.mode=nonstrict;

-- Basic setup for the staging data.
create table invoice_initial_stage (
    orderkey string, partkey string, quantity float, total float
);
insert into invoice_initial_stage values ('I-122-1023', 'P-328-382', 1, 1.3);
insert into invoice_initial_stage values ('I-122-1023', 'P-888-382', 3, 1.3);
insert into invoice_initial_stage values ('I-122-1024', 'P-234-123', 5, 5.3);

create table part_initial_stage (
    partkey string, list_price float
);
insert into part_initial_stage values ('P-328-382', 1.5);
insert into part_initial_stage values ('P-888-382', 1.8);
insert into part_initial_stage values ('P-234-123', 6.0);
insert into part_initial_stage values ('P-234-382', 9.0);
insert into part_initial_stage values ('P-943-382', 10.0);

-- The part dimension table.
-- The view hides the source system keys from end users.
create table part_0 (
    part_sk string, part_foreign_pk string, list_price float
)
CLUSTERED BY (part_foreign_pk) INTO 2 BUCKETS STORED AS ORC TBLPROPERTIES ("transactional"="true");
insert into part_0 (part_sk, part_foreign_pk, list_price)
    select
        reflect("java.util.UUID", "randomUUID"), partkey, list_price
    from
        part_initial_stage;
create view part as select part_sk, list_price from part_0;

-- Create the orders summary table.
create table orders_0 (
    order_sk string, order_foreign_pk string, total_sale float, discount_rate float
)
CLUSTERED BY (order_foreign_pk) INTO 2 BUCKETS STORED AS ORC TBLPROPERTIES ("transactional"="true");
insert into orders_0 (order_sk, order_foreign_pk, total_sale, discount_rate)
    select
        reflect("java.util.UUID", "randomUUID"), orderkey, sum(quantity*total),
        1 - sum(quantity*total) / sum(quantity*list_price)
    from
        invoice_initial_stage, part_0
    where
        partkey = part_foreign_pk
    group by
        orderkey;
create view orders as select order_sk, total_sale, discount_rate from orders_0;

-- Now the invoice fact table and view.
create table invoice_0 (
    invoice_item_id string, order_sk string, invoice_foreign_orderkey string,
    invoice_foreign_partkey string, part_sk string, quantity float, total float
)
CLUSTERED BY (invoice_foreign_orderkey) INTO 2 BUCKETS STORED AS ORC TBLPROPERTIES ("transactional"="true");
insert into invoice_0 (invoice_item_id, order_sk, invoice_foreign_orderkey, invoice_foreign_partkey, part_sk, quantity, total)
    select
        reflect("java.util.UUID", "randomUUID"), order_sk, orderkey,
        partkey, part_sk, quantity, total
    from
        orders_0, part_0, invoice_initial_stage
    where
        order_foreign_pk = orderkey and part_foreign_pk = partkey;
create view invoice as select order_sk, part_sk from invoice_0;

-- The second data load.
create table invoice_new_stage (
    orderkey string, partkey string, quantity float, total float
);
insert into invoice_new_stage values ('I-122-1025', 'P-234-382', 2, 8.3);
insert into invoice_new_stage values ('I-122-1025', 'P-943-382', 4, 9.5);
create table part_correction_stage (
    partkey string, list_price float
);
insert into part_correction_stage values ('P-888-382', 2.0);

-- Update the part dimension table based on the correction.
-- Here we are doing a Type 1 Update (Overwrite).
-- This invalidates the orders aggregate.
merge into part_0
using (
    select
        part_foreign_pk, part_correction_stage.list_price as updated_price
    from
        part_0 join part_correction_stage on part_0.part_foreign_pk = part_correction_stage.partkey
) sub
on
    (sub.part_foreign_pk = part_0.part_foreign_pk)
when matched then
    update set list_price = sub.updated_price;

-- Fix the discount rate in historical aggregates.
merge into orders_0
using (
    select
        invoice_foreign_orderkey,
        1 - sum(quantity*total) / sum(quantity*list_price) as dr
    from
        invoice_0 join part_0 on invoice_foreign_partkey = part_foreign_pk
    group by
        invoice_foreign_orderkey
) sub
on
    (order_foreign_pk = invoice_foreign_orderkey)
when matched then
    update set discount_rate = sub.dr;

-- Add in the new records, starting with orders.
insert into orders_0 (order_foreign_pk, total_sale, discount_rate)
select
    orderkey, sum(quantity*total),
    1 - sum(quantity*total) / sum(quantity*list_price)
from
    invoice_new_stage, part_0
where
    partkey = part_foreign_pk
group by
    orderkey;

insert into invoice_0 (order_sk, invoice_foreign_orderkey, invoice_foreign_partkey, part_sk, quantity, total)
select
    order_sk, orderkey, partkey, part_sk, quantity, total
from
    orders_0, part_0, invoice_new_stage
where
    order_foreign_pk = orderkey and part_foreign_pk = partkey;
