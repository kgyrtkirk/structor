-- Cross tab top average spender by order priority.
-- Only works in Hive 2.
select * from (
select
  o_custkey, o_orderpriority,
  rank() over(partition by o_orderpriority order by avg(o_totalprice) desc) r
from
  orders
group by
  o_orderpriority, o_custkey
) sub
where r <= 10;
