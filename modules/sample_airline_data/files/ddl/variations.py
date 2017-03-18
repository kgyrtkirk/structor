#!/usr/bin/python

import itertools
import os

def main():
	columns = "FlightDate UniqueCarrier AirlineID Carrier TailNum FlightNum OriginAirportID OriginAirportSeqID OriginCityMarketID Origin DestAirportID DestAirportSeqID DestCityMarketID Dest CRSDepTime DepTime DepDelay DepDelayMinutes DepDel15 DepartureDelayGroups DepTimeBlk CRSArrTime ArrTime ArrDelay ArrDelayMinutes ArrDel15 ArrivalDelayGroups ArrTimeBlk Cancelled CancellationCode Diverted CRSElapsedTime ActualElapsedTime AirTime Flights Distance DistanceGroup CarrierDelay WeatherDelay NASDelay SecurityDelay LateAircraftDelay FirstDepTime DivAirportLandings DivReachedDest DivActualElapsedTime DivArrDelay DivDistance Div1Airport Div1AirportID Div1AirportSeqID Div1WheelsOn Div1TotalGTime Div1LongestGTime Div1WheelsOff Div1TailNum".split()

	print "use airline_ontime;"
	j = 0
	for i in xrange(1, 4):
		for x in itertools.combinations(columns, i):
			sel_list = ", ".join(x)
			table = "id_{0}_{1}".format(i, j)
			sql = "drop table {0};".format(table)
			print sql
			sql = "create table {0} stored as orc TBLPROPERTIES(\"orc.bloom.filter.columns\"=\"*\") as select {1} from flights;".format(table, sel_list)
			print sql
			j += 1

main()
