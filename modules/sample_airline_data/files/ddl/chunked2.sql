create database if not exists airline_ontime;
use airline_ontime;

set hive.exec.dynamic.partition.mode=nonstrict;
set hive.optimize.sort.dynamic.partition=true;
set hive.tez.container.size=2048;

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
