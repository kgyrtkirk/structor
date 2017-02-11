create database if not exists nqueens;
use nqueens;

drop table if exists fourteen;
drop table if exists fourteen_orc;

create table fourteen (z smallint);
insert into fourteen values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14);
create table fourteen_orc stored as orc as select * from fourteen;
