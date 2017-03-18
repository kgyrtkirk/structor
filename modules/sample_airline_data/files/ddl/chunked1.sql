drop database airline_ontime cascade;
create database if not exists airline_ontime;
use airline_ontime;

set hive.exec.dynamic.partition.mode=nonstrict;
set hive.optimize.sort.dynamic.partition=true;
set hive.tez.container.size=2048;

-- Dimension tables.
drop table if exists airline_raw purge;
drop table if exists airport_raw purge;
drop table if exists cancellation_reason_raw purge;
drop table if exists deparrblk_raw purge;
drop table if exists distance_group_raw purge;
drop table if exists delay_group_raw purge;

create table airport_raw (
 iata string, city string, state double,
 country string, airport string, latitude double,
 longitude double
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",", "quoteChar" = '"', "escapeChar" = "\\")  
stored as textfile tblproperties ("skip.header.line.count"="1");

create table airline_raw (
 code string, description string, dot_code string,
 startyear int, endyear int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",", "quoteChar" = '"', "escapeChar" = "\\")  
stored as textfile tblproperties ("skip.header.line.count"="1");

create table cancellation_reason_raw (
 code string, description string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",", "quoteChar" = '"', "escapeChar" = "\\")  
stored as textfile tblproperties ("skip.header.line.count"="1");

create table deparrblk_raw (
 code string, description string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",", "quoteChar" = '"', "escapeChar" = "\\")  
stored as textfile tblproperties ("skip.header.line.count"="1");

create table distance_group_raw (
 code string, description string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",", "quoteChar" = '"', "escapeChar" = "\\")  
stored as textfile tblproperties ("skip.header.line.count"="1");

create table delay_group_raw (
 code string, description string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",", "quoteChar" = '"', "escapeChar" = "\\")  
stored as textfile tblproperties ("skip.header.line.count"="1");

LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/dim/airline_dim.csv.gz' INTO TABLE airline_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/dim/airport_dim.csv.gz' INTO TABLE airport_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/dim/L_CANCELLATION.csv.gz' INTO TABLE cancellation_reason_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/dim/L_DEPARRBLK.csv.gz' INTO TABLE deparrblk_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/dim/L_DISTANCE_GROUP_250.csv.gz' INTO TABLE distance_group_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/dim/L_ONTIME_DELAY_GROUPS.csv.gz' INTO TABLE delay_group_raw;

drop table if exists airline purge;
create table airline STORED AS ORC as select * from airline_raw;
drop table if exists airport purge;
create table airport STORED AS ORC as select * from airport_raw;
drop table if exists cancellation_reason purge;
create table cancellation_reason STORED AS ORC as select * from cancellation_reason_raw;
drop table if exists deparrblk purge;
create table deparrblk STORED AS ORC as select * from deparrblk_raw;
drop table if exists distance_group purge;
create table distance_group STORED AS ORC as select * from distance_group_raw;
drop table if exists delay_group purge;
create table delay_group STORED AS ORC as select * from delay_group_raw;

-- Fact table.
drop table if exists flights_raw purge;
create table flights_raw (
  Year int, Quarter int, Month int, DayofMonth int,
  DayOfWeek int, FlightDate string, UniqueCarrier string, AirlineID int,
  Carrier string, TailNum string, FlightNum string, OriginAirportID int,
  OriginAirportSeqID int, OriginCityMarketID int, Origin string,
  OriginCityName string, OriginState string,
  OriginStateFips string, OriginStateName string, OriginWac int,
  DestAirportID int, DestAirportSeqID int, DestCityMarketID int, Dest string,
  DestCityName string, DestState string,
  DestStateFips string,
  DestStateName string,
  DestWac int, CRSDepTime int, DepTime string, DepDelay int,
  DepDelayMinutes int, DepDel15 int, DepartureDelayGroups int, DepTimeBlk string,
  TaxiOut int, WheelsOff string, WheelsOn string, TaxiIn int,
  CRSArrTime int, ArrTime string, ArrDelay int, ArrDelayMinutes int,
  ArrDel15 int, ArrivalDelayGroups int, ArrTimeBlk string, Cancelled int,
  CancellationCode string, Diverted int, CRSElapsedTime int, ActualElapsedTime int,
  AirTime int, Flights int, Distance int, DistanceGroup int,
  CarrierDelay int, WeatherDelay int, NASDelay int, SecurityDelay int,
  LateAircraftDelay int, FirstDepTime string, TotalAddGTime int, LongestAddGTime int,
  DivAirportLandings int, DivReachedDest int, DivActualElapsedTime int, DivArrDelay int,
  DivDistance int, Div1Airport string, Div1AirportID int, Div1AirportSeqID int,
  Div1WheelsOn string, Div1TotalGTime int, Div1LongestGTime int, Div1WheelsOff string,
  Div1TailNum string, Div2Airport string, Div2AirportID int, Div2AirportSeqID int,
  Div2WheelsOn string, Div2TotalGTime int, Div2LongestGTime int, Div2WheelsOff string,
  Div2TailNum string, Div3Airport string, Div3AirportID int, Div3AirportSeqID int,
  Div3WheelsOn string, Div3TotalGTime int, Div3LongestGTime int, Div3WheelsOff string,
  Div3TailNum string, Div4Airport string, Div4AirportID int, Div4AirportSeqID int,
  Div4WheelsOn string, Div4TotalGTime int, Div4LongestGTime int, Div4WheelsOff string,
  Div4TailNum string, Div5Airport string, Div5AirportID int, Div5AirportSeqID int,
  Div5WheelsOn string, Div5TotalGTime int, Div5LongestGTime int, Div5WheelsOff string,
  Div5TailNum string
) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",", "quoteChar" = '"', "escapeChar" = "\\")  
stored as textfile tblproperties ("skip.header.line.count"="1");

drop table if exists flights purge;
create table flights (
  FlightDate date, UniqueCarrier string, AirlineID string,
  Carrier string, TailNum string, FlightNum string, OriginAirportID string,
  OriginAirportSeqID string, OriginCityMarketID string, Origin string,
  OriginStateFips string, OriginWac string, DestAirportID string, DestAirportSeqID string,
  DestCityMarketID string, Dest string, DestStateFips string, DestWac string,
  CRSDepTime int, DepTime int, DepDelay int, DepDelayMinutes int, DepDel15 boolean,
  DepartureDelayGroups string, DepTimeBlk string, TaxiOut int, WheelsOff string,
  WheelsOn string, TaxiIn int, CRSArrTime int, ArrTime int, ArrDelay int,
  ArrDelayMinutes int, ArrDel15 boolean, ArrivalDelayGroups string, ArrTimeBlk string,
  Cancelled boolean, CancellationCode string, Diverted boolean, CRSElapsedTime int,
  ActualElapsedTime int, AirTime int, Flights int, Distance int, DistanceGroup string,
  CarrierDelay int, WeatherDelay int, NASDelay int, SecurityDelay int, LateAircraftDelay int,
  FirstDepTime int, TotalAddGTime int, LongestAddGTime int, DivAirportLandings int,
  DivReachedDest boolean, DivActualElapsedTime int, DivArrDelay int, DivDistance int,
  Div1Airport string, Div1AirportID string, Div1AirportSeqID string, Div1WheelsOn string,
  Div1TotalGTime int, Div1LongestGTime int, Div1WheelsOff string, Div1TailNum string,
  Div2Airport string, Div2AirportID string, Div2AirportSeqID string, Div2WheelsOn string,
  Div2TotalGTime int, Div2LongestGTime int, Div2WheelsOff string, Div2TailNum string,
  Div3Airport string, Div3AirportID string, Div3AirportSeqID string, Div3WheelsOn string,
  Div3TotalGTime int, Div3LongestGTime int, Div3WheelsOff string, Div3TailNum string,
  Div4Airport string, Div4AirportID string, Div4AirportSeqID string, Div4WheelsOn string,
  Div4TotalGTime int, Div4LongestGTime int, Div4WheelsOff string, Div4TailNum string,
  Div5Airport string, Div5AirportID string, Div5AirportSeqID string, Div5WheelsOn string,
  Div5TotalGTime int, Div5LongestGTime int, Div5WheelsOff string, Div5TailNum string
) PARTITIONED BY (Year int)
STORED AS ORC;

LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1988_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1989_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1990_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1991_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1992_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1993_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1994_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1995_9.csv.bz2' INTO TABLE flights_raw;

-- Load some data.
insert into table flights partition(year)
select
  cast(concat(year, "-", month, "-", dayofmonth) as date) as FlightDate,
  UniqueCarrier, AirlineID, Carrier,
  TailNum, FlightNum, OriginAirportID, OriginAirportSeqID,
  OriginCityMarketID, Origin,
  OriginStateFips, OriginWac, DestAirportID,
  DestAirportSeqID, DestCityMarketID, Dest,
  DestStateFips, DestWac,
  CRSDepTime, DepTime, DepDelay, DepDelayMinutes,
  case when DepDel15 = 0 then false else true end,
  DepartureDelayGroups, DepTimeBlk, TaxiOut,
  WheelsOff, WheelsOn, TaxiIn, CRSArrTime,
  ArrTime, ArrDelay, ArrDelayMinutes,
  case when ArrDel15 = 0 then false else true end,
  ArrivalDelayGroups, ArrTimeBlk,
  case when Cancelled = 0 then false else true end,
  CancellationCode,
  case when Diverted = 0 then false else true end,
  CRSElapsedTime, ActualElapsedTime, AirTime,
  Flights, Distance, DistanceGroup, CarrierDelay,
  WeatherDelay, NASDelay, SecurityDelay, LateAircraftDelay,
  FirstDepTime, TotalAddGTime, LongestAddGTime, DivAirportLandings,
  case when DivReachedDest = 0 then false else true end,
  DivActualElapsedTime, DivArrDelay, DivDistance,
  Div1Airport, Div1AirportID, Div1AirportSeqID, Div1WheelsOn,
  Div1TotalGTime, Div1LongestGTime, Div1WheelsOff, Div1TailNum,
  Div2Airport, Div2AirportID, Div2AirportSeqID, Div2WheelsOn,
  Div2TotalGTime, Div2LongestGTime, Div2WheelsOff, Div2TailNum,
  Div3Airport, Div3AirportID, Div3AirportSeqID, Div3WheelsOn,
  Div3TotalGTime, Div3LongestGTime, Div3WheelsOff, Div3TailNum,
  Div4Airport, Div4AirportID, Div4AirportSeqID, Div4WheelsOn,
  Div4TotalGTime, Div4LongestGTime, Div4WheelsOff, Div4TailNum,
  Div5Airport, Div5AirportID, Div5AirportSeqID, Div5WheelsOn,
  Div5TotalGTime, Div5LongestGTime, Div5WheelsOff, Div5TailNum,
  year
  from flights_raw
order by FlightDate;

truncate table flights_raw;
