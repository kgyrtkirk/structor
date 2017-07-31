{
  "os": "centos7",
  "hdp_short_version": "2.6.1",
  "java_version": "java-1.8.0-openjdk",
  "vm_mem": 12288,
  "vm_cpus": 4,

  "am_mem": 512,
  "server_mem": 768,
  "client_mem": 1024,
  "extra_os_mem": 4096,

  "security": false,
  "domain": "example.com",
  "realm": "EXAMPLE.COM",

  "clients" : [ "druid", "hdfs", "hive2", "yarn", "zk" ],
  "nodes": [
    {"hostname": "druid", "ip": "192.168.59.31",
     "roles": ["client",
               "druid-broker", "druid-coordinator", "druid-historical",
               "druid-middlemanager", "druid-overlord", "druid-flighttracker",
               "hive2", "hive2-server2", "hive-db", "hive2-meta",
               "httpd", "kafka", "nn", "slave", "superset", "tez-ui",
               "yarn", "yarn-timelineserver", "zk"]}
  ],

  "hive_options" : "acid,interactive",

  "extras": [ "sample-hive-data" ]
}
