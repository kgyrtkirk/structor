create database if not exists nqueens;
use nqueens;

drop table if exists nine;
drop table if exists nine_orc;

create table nine (z bigint);
insert into nine values (1), (2), (3), (4), (5), (6), (7), (8), (9);
create table nine_orc stored as orc as select * from nine;
