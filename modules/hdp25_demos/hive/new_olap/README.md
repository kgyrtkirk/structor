Hive 2.1 adds many new capabilities to the existing OLAP ("over clause")
functionality of Hive. Most notably:

* Support for multiple "partition by" statements.
* Support for multiple "order by" statements.
* Ability to "order by" a UDF or UDAF (for example: order by an average)
* Ability to specific that nulls should be first or be last.

Demos are included here. These demos assume a populated TPC-H schema.
