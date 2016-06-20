use tpch_bin_flat_acid_2;

insert into table lineitem select * from lineitem_stage;
insert into table orders select * from orders_stage;
delete from lineitem where L_ORDERKEY in (select D_ORDERKEY from delete_stage);
delete from orders   where O_ORDERKEY in (select D_ORDERKEY from delete_stage);
