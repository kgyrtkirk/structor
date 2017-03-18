create database if not exists airline_ontime;
use airline_ontime;

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
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1996_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1997_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1998_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_1999_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2000_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2001_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2002_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2003_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2004_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2005_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2006_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2007_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2008_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2009_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2010_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2011_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2012_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2013_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2014_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_11.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_12.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2015_9.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2016_1.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2016_10.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2016_2.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2016_3.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2016_4.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2016_5.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2016_6.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2016_7.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2016_8.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/vagrant/modules/sample_airline_data/files/raw/fact/On_Time_On_Time_Performance_2016_9.csv.bz2' INTO TABLE flights_raw;
