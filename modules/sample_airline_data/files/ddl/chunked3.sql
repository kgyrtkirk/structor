create database if not exists airline_ontime;
use airline_ontime;

set hive.exec.dynamic.partition.mode=nonstrict;
set hive.optimize.sort.dynamic.partition=true;
set hive.tez.container.size=2048;

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
