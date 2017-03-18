create database if not exists airline_ontime;
use airline_ontime;

set hive.exec.dynamic.partition.mode=nonstrict;
set hive.optimize.sort.dynamic.partition=true;
set hive.tez.container.size=2048;

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
