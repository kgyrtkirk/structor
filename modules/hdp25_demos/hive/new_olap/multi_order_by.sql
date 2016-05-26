-- Doesn't work in Hive 1 because of multiple order by clauses.
select
  o_custkey, o_orderpriority, o_shippriority,
  count(*) over (partition by o_custkey order by o_orderpriority, o_shippriority)
from
  orders
group by
  o_custkey, o_orderpriority, o_shippriority
limit 10;
