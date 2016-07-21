#!/bin/sh

cd /tmp
sudo -u hive hive2 --service llap --instances 1 --cache 1024m --executors 6 --size 7168m --xmx 5632m --loglevel WARN --slider-am-container-mb 512  --args "-XX:+UseG1GC -XX:TLABSize=8m -XX:+ResizeTLAB -XX:+AggressiveOpts -XX:+AlwaysPreTouch -XX:InitiatingHeapOccupancyPercent=80 -XX:MaxGCPauseMillis=200 -XX:HeapDumpPath=/tmp/llap.hprof -XX:-HeapDumpOnOutOfMemoryError"
sudo rm -rf /usr/hdp/llap-slider
sudo mv /tmp/llap-slider-* /usr/hdp/llap-slider
