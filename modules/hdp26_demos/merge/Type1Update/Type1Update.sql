drop database if exists type1_test cascade;
create database type1_test;
use type1_test;

drop table if exists customer;
drop table if exists customer_updates;

create table customer ( id int, name string, state string)
CLUSTERED BY (id) INTO 2 BUCKETS STORED AS ORC TBLPROPERTIES ("transactional"="true");

insert into customer values ( 1, "Abc Co.", "OH" ), ( 2, "Xyz Co.", "CA" );

create table new_customer_stage ( id int, name string, state string);
insert into customer_updates values ( 1, "Abc Co.", "OH" ), ( 2, "Xyz Co.", "TX" ), ( 3, "Ghi Co.", "GA" )

merge into customer
using ( select * from new_customer_stage) sub
on sub.id = customer.id
when matched then update set name = sub.name, state = sub.new_state
when not matched then insert values (sub.id, sub.name, sub.state);

-- Alternate:
-- drop table if exists customer_merged;
-- create table customer_merged as
-- select
-- customer.id,
-- coalesce(customer_updates.name, customer.name),
-- coalesce(customer_updates.staate, customer.state)
-- from
-- customer left outer join customer_updates on customer.id = customer_updates.id;
-- insert overwite customer select * from customer_merged;
-- drop table customer_merged;
