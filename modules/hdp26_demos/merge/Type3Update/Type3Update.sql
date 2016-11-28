drop database if exists type3_test cascade;
create database type3_test;
use type3_test;

drop table if exists customer;
drop table if exists customer_updates;

create table customer (
  id int,
  name string,
  original_state string,
  effective_date date,
  current_state string
)
CLUSTERED BY (id) INTO 2 BUCKETS STORED AS ORC TBLPROPERTIES ("transactional"="true");

insert into customer values
( 1, "Abc Co.", null, "2012-01-01", "OH" ),
( 2, "Def Co.", null, "2013-01-01", "PA" ),
( 3, "Xyz Co.", null, "2014-01-01", "CA" );
select * from customer order by id;

create table customer_updates (
  id int,
  new_state string
);
insert into customer_updates values ( 3, "TX");

merge into customer
using (
  select * from customer_updates
) sub
on sub.id = customer.id
when matched
then update set
  effective_date = current_date(),
  original_state = current_state,
  current_state = new_state;
select * from customer order by id;
