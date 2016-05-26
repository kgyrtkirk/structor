SQL systems provide concepts like schemas and namespaces to enforce security
and prevent accidental overwite of data.

Phoenix 4.7 introduces a way to map Phoenix tables to HBase namespaces, allowing
admins to enforce access controls using standard HBase ACLs.

To use this feature, phoenix.connection.isNamespaceMappingEnabled must be set
to true.

Within a Phoenix client you can issue "create schema" commands:
create schema customer_a;
create schema customer_b;

Then tables can be created within these schemas:
create table customer_a.test (id integer primary key);
create table customer_b.test (id integer primary key);

Security controls are handled in the HBase shell:
grant 'user1', 'RWC', 'SYSTEM.CATALOG'
grant 'user1', 'C', 'SYSTEM.SEQUENCE'
grant 'user1', 'C', 'SYSTEM.STATS'
grant 'user1', 'C', 'SYSTEM.FUNCTION'

grant 'user2', 'RWC', 'SYSTEM.CATALOG'
grant 'user2', 'C', 'SYSTEM.SEQUENCE'
grant 'user2', 'C', 'SYSTEM.STATS'
grant 'user2', 'C', 'SYSTEM.FUNCTION'

grant 'user1', 'RWXCA', '@CUSTOMER_A'
grant 'user2', 'R', '@CUSTOMER_A'
grant 'user2', 'RWXCA', '@CUSTOMER_B'

Limitations:
SQL users can see all tables in all namespaces.
