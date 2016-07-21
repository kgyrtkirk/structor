import pyodbc

cnxn = pyodbc.connect('DSN=Hortonworks Hive DSN;UID=vagrant;PWD=vagrant', autocommit=True)
cursor = cnxn.cursor()

print "Warmup"
query = """
SELECT SUM(`lineitem`.`l_extendedprice`) AS `sum_l_extendedprice_ok`, COUNT(1) AS `x__alias__0` FROM `tpch_bin_flat_orc_2`.`lineitem` `lineitem` JOIN `tpch_bin_flat_orc_2`.`orders` `orders` ON (`lineitem`.`l_orderkey` = `orders`.`o_orderkey`) JOIN `tpch_bin_flat_orc_2`.`customer` `customer` ON (`orders`.`o_custkey` = `customer`.`c_custkey`) JOIN `tpch_bin_flat_orc_2`.`nation` `nation` ON (`customer`.`c_nationkey` = `nation`.`n_nationkey`) WHERE ((((NOT (`lineitem`.`l_partkey` IS NULL)) AND (NOT (`lineitem`.`l_suppkey` IS NULL))) AND ((NOT (`lineitem`.`l_partkey` IS NULL)) AND (NOT (`lineitem`.`l_suppkey` IS NULL)))) AND (NOT (`nation`.`n_regionkey` IS NULL))) GROUP BY 1 HAVING (COUNT(1) > 0)
"""
cursor.execute(query)
row = cursor.fetchone()
if row:
	print row


print "Warmup2"
query = """
SELECT `lineitem`.`l_shipinstruct` AS `l_shipinstruct`, SUM(`lineitem`.`l_extendedprice`) AS `sum_l_extendedprice_ok` FROM `tpch_bin_flat_orc_2`.`lineitem` `lineitem` JOIN `tpch_bin_flat_orc_2`.`orders` `orders` ON (`lineitem`.`l_orderkey` = `orders`.`o_orderkey`) JOIN `tpch_bin_flat_orc_2`.`customer` `customer` ON (`orders`.`o_custkey` = `customer`.`c_custkey`) JOIN `tpch_bin_flat_orc_2`.`nation` `nation` ON (`customer`.`c_nationkey` = `nation`.`n_nationkey`) WHERE ((((NOT (`lineitem`.`l_partkey` IS NULL)) AND (NOT (`lineitem`.`l_suppkey` IS NULL))) AND ((NOT (`lineitem`.`l_partkey` IS NULL)) AND (NOT (`lineitem`.`l_suppkey` IS NULL)))) AND (NOT (`nation`.`n_regionkey` IS NULL))) GROUP BY `lineitem`.`l_shipinstruct`
"""
cursor.execute(query)
row = cursor.fetchone()
if row:
	print row


print "Warmup3"
query = """
SELECT `lineitem`.`l_shipinstruct` AS `l_shipinstruct`, `lineitem`.`l_shipmode` AS `l_shipmode`, SUM(`lineitem`.`l_extendedprice`) AS `sum_l_extendedprice_ok` FROM `tpch_bin_flat_orc_2`.`lineitem` `lineitem` JOIN `tpch_bin_flat_orc_2`.`orders` `orders` ON (`lineitem`.`l_orderkey` = `orders`.`o_orderkey`) JOIN `tpch_bin_flat_orc_2`.`customer` `customer` ON (`orders`.`o_custkey` = `customer`.`c_custkey`) JOIN `tpch_bin_flat_orc_2`.`nation` `nation` ON (`customer`.`c_nationkey` = `nation`.`n_nationkey`) WHERE ((((NOT (`lineitem`.`l_partkey` IS NULL)) AND (NOT (`lineitem`.`l_suppkey` IS NULL))) AND ((NOT (`lineitem`.`l_partkey` IS NULL)) AND (NOT (`lineitem`.`l_suppkey` IS NULL)))) AND (NOT (`nation`.`n_regionkey` IS NULL))) GROUP BY `lineitem`.`l_shipinstruct`, `lineitem`.`l_shipmode`
"""
cursor.execute(query)
row = cursor.fetchone()
if row:
	print row




