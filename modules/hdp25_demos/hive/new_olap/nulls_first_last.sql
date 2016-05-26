-- Lowest spenders who had some level of activity.
-- Only works in Hive 2.
select
  o_custkey,
  rank() over (order by sum(o_totalprice) nulls last)
from
  orders
group by
  o_custkey
limit 10;
