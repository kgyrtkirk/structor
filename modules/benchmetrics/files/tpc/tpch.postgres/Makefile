all: target/TPCH_Tools.zip target/tpch_2_17_0/dbgen/dbgen

target/TPCH_Tools.zip:
	echo "Download TPCH_Tools.zip and place into the target directory"
	false

target/tpch_2_17_0/dbgen/dbgen:
	( cd target && unzip -o TPCH_Tools.zip )
	( cd target/tpch_2_17_0/dbgen && make -f makefile.suite clean; make -f makefile.suite CC=gcc DATABASE=ORACLE MACHINE=LINUX WORKLOAD=TPCH )

clean:
	(cd target/tpch_2_17_0/dbgen && make -f makefile.suite clean)
