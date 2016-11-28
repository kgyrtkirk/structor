drop table if exists date_dim;
create table date_dim (
    id int,
    cal_date date,
    weeknum int,
    dayofyear int,
    dayofweek int,
    lastdayofweek boolean,
    weekend boolean,
    holiday boolean,
    lastdayofmonth boolean,
    holidayweek boolean
)
row format delimited fields terminated by ','
TBLPROPERTIES ("skip.header.line.count"="1");

load data local inpath '/vagrant/modules/hdp26_demos/merge/AccumulatingSnapshot/dates.csv.bz2' into table date_dim;
