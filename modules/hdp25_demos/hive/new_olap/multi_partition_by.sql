-- Multi partition by.
select
  c_custkey,
  rank() over (partition by c_nationkey, c_mktsegment order by sum(o_totalprice))
from
  customer, orders
where
  customer.c_custkey = orders.o_custkey
group by
  c_custkey, c_nationkey, c_mktsegment
limit 10;
