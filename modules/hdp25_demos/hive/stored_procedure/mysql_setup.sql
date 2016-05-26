use hive;
drop table if exists state;
create table state (load_date varchar(80), runid varchar(80), status boolean);
