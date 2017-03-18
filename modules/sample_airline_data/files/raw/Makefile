ZIPS=$(wildcard *.zip)
BZ=$(ZIPS:.zip=.csv.bz2)

all: $(BZ)

%.csv.bz2 : %.zip
	unzip -o $^
	bzip2 -9 $*.csv
	rm $^
