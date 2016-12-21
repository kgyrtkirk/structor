all: target/TPCDS_Tools.zip target/v1.4.0/tools/dsdgen

target/TPCDS_Tools.zip:
	echo "Download TPCDS_Tools.zip and place into the target directory"
	false

target/v1.4.0/tools/dsdgen:
	( cd target && unzip -o TPCDS_Tools.zip )
	( cd target/v1.4.0/tools && cat ../../../patches/*.patch | patch -p0 )
	( cd target/v1.4.0/tools && make clean; make dsdgen )

clean:
	-(cd target/v1.4.0/tools && make clean)
	(cd target ; mvn clean)
