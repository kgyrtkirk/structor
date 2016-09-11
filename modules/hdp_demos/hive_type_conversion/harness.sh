#!/bin/sh

ROOT=`dirname $0`

# Dependencies.
sudo yum install -y epel-release
sudo yum install -y graphviz graphviz-devel python-pip git graphviz-python
sudo pip install pygraphviz
sudo pip install flask

# Get the UDF code.
git clone https://github.com/cartershanklin/sample-hiveudf
cd sample-hiveudf

# Get the blackbox output.
HIVE=hive
mvn package
$HIVE --version | head -1 > version.txt
python $ROOT/generate.py > blackbox.sql ; export HADOOP_CLASSPATH=target/sample-hiveudf-1.0-SNAPSHOT.jar ; $HIVE -S -f blackbox.sql > blackbox.txt

# Generate the comparison matrix and dependency graph.
python $ROOT/process_results.py
