-- This update strategy uses a helper table to generate multiple output rows for
-- type 2 updates. First we classify needed update types into type 1 (insert)
-- type 2 (partition) and discard which is marked as 0.
--
-- The helper table contains two matches for type 2. One of these includes an
-- invalid key that will turn into an insert. The other one will be used for
-- an update.

drop database if exists type2_scd_helper cascade;
create database type2_scd_helper;
use type2_scd_helper;

drop table if exists customer;
drop table if exists customer_updates;
drop table if exists new_customer_stage;

create table customer (
  source_pk int,
  sk string,
  name string,
  state string,
  is_current boolean,
  end_date date
)
CLUSTERED BY (sk) INTO 2 BUCKETS STORED AS ORC TBLPROPERTIES ("transactional"="true");

insert into customer values
( 1, "ABC", "Abc Co.", "OH", true, null ),
( 2, "DEF", "Def Co.", "PA", true, null ),
( 3, "XYZ", "Xyz Co.", "CA", true, null );
select * from customer order by source_pk;

create table new_customer_stage (
  source_pk int,
  name string,
  state string
);
insert into new_customer_stage values
( 1, "Abc Co.", "OH" ),
( 2, "Def Co.", "PA" ),
( 3, "Xyz Co.", "TX" ),
( 4, "Pdq Co.", "WI" );

-- This query produces a list of the updates we need, by type.
-- select
--   stage.source_pk, stage.name, stage.state,
--   case when customer.source_pk is null then 1
--   when stage.name <> customer.name or stage.state <> customer.state then 2
--   else 0 end
-- from
--   new_customer_stage stage
-- left join
--   customer
-- on (stage.source_pk = customer.source_pk and customer.is_current = true);

-- The -1 will product a match miss which will cause a new insert.
-- The null values will be converted to valid IDs using coalesce.
drop table if exists scd_types;
create table scd_types (
  type int,
  invalid_key int
);
insert into scd_types values (1, null), (2, -1), (2, null);

merge into customer
using (
  select
    *,
    coalesce(invalid_key, source_pk) as join_key
  from (
    select
      stage.source_pk, stage.name, stage.state,
      case when customer.source_pk is null then 1
      when stage.name <> customer.name or stage.state <> customer.state then 2
      else 0 end as scd_row_type
    from
      new_customer_stage stage
    left join
      customer
    on (stage.source_pk = customer.source_pk and customer.is_current = true)
  ) updates
  join scd_types on scd_types.type = scd_row_type
) sub
on sub.join_key = customer.source_pk
when matched then update set
  is_current = false,
  end_date = current_date()
when not matched then insert values
  (sub.source_pk, upper(substr(sub.name, 0, 3)), sub.name, sub.state, true, null);
select * from customer order by source_pk;
