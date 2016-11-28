use airline_ontime;

set hive.exec.dynamic.partition.mode=nonstrict;
set hive.optimize.sort.dynamic.partition=true;
set hive.tez.container.size=2048;

drop table if exists flights purge;
drop table if exists airports purge;
drop table if exists airlines purge;
drop table if exists planes purge;

create table airports (
    iata string, airport string, city string,
    state string, country string, lat double, lon double
) STORED AS ORC;
insert overwrite table airports select * from airports_raw;

create table airlines (
    code string, description string
) STORED AS ORC;
insert overwrite table airlines select * from airlines_raw;

create table planes (
    tailnum string, owner_type string,
    manufacturer string, issue_date date,
    model string, status string,
    aircraft_type string, engine_type string, year int
) STORED AS ORC;

insert overwrite table planes select
    tailnum, owner_type, manufacturer,
    cast (concat(substr(issue_date, 7, 4), "-", substr(issue_date, 4, 2), "-", substr(issue_date, 1, 2)) as date),
    model, status, aircraft_type, engine_type, year
from planes_raw;

create table flights (
  FlightDate date, DepTime int, CRSDepTime int,
  ArrTime int, CRSArrTime int, UniqueCarrier string,
  FlightNum int, TailNum string, ActualElapsedTime int,
  CRSElapsedTime int, AirTime int, ArrDelay int,
  DepDelay int, Origin string, Dest string,
  Distance int, TaxiIn int, TaxiOut int,
  Cancelled boolean, CancellationCode string, Diverted boolean,
  CarrierDelay int, WeatherDelay int, NASDelay int,
  SecurityDelay int, LateAircraftDelay int
) 
PARTITIONED BY (Year int)
STORED AS ORC
TBLPROPERTIES("orc.bloom.filter.columns"="*");

insert overwrite table flights partition(year) 
select
  cast(concat(year, "-", month, "-", dayofmonth) as date) as FlightDate,
  DepTime, CRSDepTime, ArrTime,
  CRSArrTime, UniqueCarrier, FlightNum,
  TailNum, ActualElapsedTime, CRSElapsedTime,
  AirTime, ArrDelay, DepDelay,
  Origin, Dest, Distance,
  TaxiIn, TaxiOut,
  case when Cancelled = 0 then false else true end,
  CancellationCode,
  case when Diverted = 0 then false else true end,
  CarrierDelay,
  WeatherDelay, NASDelay, SecurityDelay,
  LateAircraftDelay, Year
  from flights_raw
order by FlightDate;
