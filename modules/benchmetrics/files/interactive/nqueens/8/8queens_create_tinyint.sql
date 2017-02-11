create database if not exists nqueens;
use nqueens;

drop table if exists eight;
drop table if exists eight_orc;

create table eight (z tinyint);
insert into eight values (1), (2), (3), (4), (5), (6), (7), (8);
create table eight_orc stored as orc as select * from eight;
