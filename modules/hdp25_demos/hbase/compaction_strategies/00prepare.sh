#!/bin/sh

# Run this on the VM.
cd /home/vagrant

# Get YCSB.
sudo yum install git
git clone https://github.com/cartershanklin/YCSB

maven_version=3.3.9
which mvn > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Maven not found, automatically installing it."
	curl -O http://mirrors.ibiblio.org/apache/maven/maven-3/$maven_version/binaries/$maven_bin
	curl -O http://www.us.apache.org/dist/maven/maven-3/$maven_version/binaries/apache-maven-$maven_version-bin.tar.gz 2> /dev/null
	if [ $? -ne 0 ]; then
		echo "Failed to download Maven, check Internet connectivity and try again."
		exit 1
	fi
	tar -zxf apache-maven-$maven_version-bin.tar.gz > /dev/null
	CWD=$(pwd)
	export MAVEN_HOME="$CWD/apache-maven-$maven_version"
	export PATH=$PATH:$MAVEN_HOME/bin
fi

# Build.
cd YCSB
mvn clean package

# Create the table in HBase.
cat<<EOF>temp.txt
disable 'user'
drop 'user'
create 'user', 'f'
EOF
hbase shell < temp.txt

read -p "YCSB, workload A, ordinary table"
bin/ycsb load hbase10 -P workloads/workloada -cp /etc/hbase/conf -p table=user -p columnfamily=f -p recordcount=500000 -s -threads 8

# Create a FIFO compaction table.
cat<<EOF>temp.txt
disable 'user'
drop 'user'
create 'user', {NAME=>'f', TTL=>'180'}, {CONFIGURATION => {'hbase.hstore.defaultengine.compactionpolicy.class' => 'org.apache.hadoop.hbase.regionserver.compactions.FIFOCompactionPolicy', 'hbase.hstore.blockingStoreFiles' => 1000}}
EOF
hbase shell < temp.txt

read -p "YCSB, workload A, FIFO compaction strategy"
bin/ycsb load hbase10 -P workloads/workloada -cp /etc/hbase/conf -p table=user -p columnfamily=f -p recordcount=500000 -s -threads 8

cat<<EOF>temp.txt
disable 'user'
drop 'user'
create 'user', 'f'
EOF
hbase shell < temp.txt

read -p "YCSB, custom scanning workload, without date-tiered compaction strategy"
bin/ycsb load hbase10 -P workloads/workload_scan -cp /etc/hbase/conf -p table=user -p columnfamily=f -p recordcount=500000 -p operationcount=500000 -s -threads 8
bin/ycsb run hbase10 -P workloads/workload_scan -cp /etc/hbase/conf -p table=user -p columnfamily=f -p recordcount=500000 -p operationcount=500000 -s -threads 8


cat<<EOF>temp.txt
disable 'user'
drop 'user'
create 'user', 'f', CONFIGURATION => {'hbase.hstore.engine.class' => 'org.apache.hadoop.hbase.regionserver.DateTieredStoreEngine', 'hbase.hstore.blockingStoreFiles' => '60', 'hbase.hstore.compaction.min'=>'2', 'hbase.hstore.compaction.max'=>'60'}
EOF
hbase shell < temp.txt

read -p "YCSB, custom scanning workload, demo of date-tiered compaction strategy"
bin/ycsb load hbase10 -P workloads/workload_scan -cp /etc/hbase/conf -p table=user -p columnfamily=f -p recordcount=500000 -p operationcount=500000 -s -threads 8
bin/ycsb run hbase10 -P workloads/workload_scan -cp /etc/hbase/conf -p table=user -p columnfamily=f -p recordcount=500000 -p operationcount=500000 -s -threads 8










