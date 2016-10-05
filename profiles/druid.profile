{
  "os": "centos7",
  "hdp_short_version": "2.5.0",
  "vm_mem": 12288,
  "vm_cpus": 4,

  "am_mem": 512,
  "server_mem": 768,
  "client_mem": 1024,

  "security": false,
  "domain": "example.com",
  "realm": "EXAMPLE.COM",

  "clients" : [ "hdfs", "hive", "spark", "tez", "yarn", "zk" ],
  "nodes": [
    {"hostname": "druid", "ip": "192.168.59.31",
     "roles": ["client",
               "druid-broker", "druid-coordinator", "druid-historical",
               "druid-middlemanager", "druid-overlord",
               "hive-db", "hive-meta", "hive-server2", "httpd",
               "kafka", "nn", "slave", "spark-thriftserver",
               "yarn", "yarn-timelineserver", "zk"]}
  ],

  "hive_options" : "interactive",

  "extras": [ "sample-hive-data" ]
}
