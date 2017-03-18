use airline_ontime;

set hive.exec.dynamic.partition.mode=nonstrict;
set hive.optimize.sort.dynamic.partition=true;
set hive.tez.container.size=2048;

drop table if exists airline purge;
create table airline STORED AS ORC as select * from airline_raw;
drop table if exists airport purge;
create table airport STORED AS ORC as select * from airport_raw;
drop table if exists cancellation purge;
create table cancellation STORED AS ORC as select * from cancellation_raw;
drop table if exists deparrblk purge;
create table deparrblk STORED AS ORC as select * from deparrblk_raw;
drop table if exists distance_group purge;
create table distance_group STORED AS ORC as select * from distance_group_raw;
drop table if exists delay_group purge;
create table delay_group STORED AS ORC as select * from delay_group_raw;

drop table if exists flights purge;
create table flights (
  FlightDate date, UniqueCarrier string, AirlineID int,
  Carrier string, TailNum string, FlightNum string, OriginAirportID int,
  OriginAirportSeqID int, OriginCityMarketID int, Origin string,
  OriginStateFips string, OriginWac int,
  DestAirportID int, DestAirportSeqID int, DestCityMarketID int, Dest string,
  DestStateFips string,
  DestWac int, CRSDepTime int, DepTime string, DepDelay int, DepDelayMinutes int,
  DepDel15 boolean, DepartureDelayGroups int, DepTimeBlk string, TaxiOut int,
  WheelsOff string, WheelsOn string, TaxiIn int, CRSArrTime int,
  ArrTime string, ArrDelay int, ArrDelayMinutes int, ArrDel15 boolean,
  ArrivalDelayGroups int, ArrTimeBlk string, Cancelled boolean, CancellationCode string,
  Diverted boolean, CRSElapsedTime int, ActualElapsedTime int, AirTime int,
  Flights int, Distance int, DistanceGroup int, CarrierDelay int,
  WeatherDelay int, NASDelay int, SecurityDelay int, LateAircraftDelay int,
  FirstDepTime string, TotalAddGTime int, LongestAddGTime int, DivAirportLandings int,
  DivReachedDest boolean, DivActualElapsedTime int, DivArrDelay int, DivDistance int,
  Div1Airport string, Div1AirportID int, Div1AirportSeqID int, Div1WheelsOn string,
  Div1TotalGTime int, Div1LongestGTime int, Div1WheelsOff string, Div1TailNum string,
  Div2Airport string, Div2AirportID int, Div2AirportSeqID int, Div2WheelsOn string,
  Div2TotalGTime int, Div2LongestGTime int, Div2WheelsOff string, Div2TailNum string,
  Div3Airport string, Div3AirportID int, Div3AirportSeqID int, Div3WheelsOn string,
  Div3TotalGTime int, Div3LongestGTime int, Div3WheelsOff string, Div3TailNum string,
  Div4Airport string, Div4AirportID int, Div4AirportSeqID int, Div4WheelsOn string,
  Div4TotalGTime int, Div4LongestGTime int, Div4WheelsOff string, Div4TailNum string,
  Div5Airport string, Div5AirportID int, Div5AirportSeqID int, Div5WheelsOn string,
  Div5TotalGTime int, Div5LongestGTime int, Div5WheelsOff string, Div5TailNum string
) 
PARTITIONED BY (Year int)
STORED AS ORC
TBLPROPERTIES("orc.bloom.filter.columns"="*");

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
