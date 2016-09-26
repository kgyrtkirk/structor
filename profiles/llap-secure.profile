{
  "os": "centos7",
  "hdp_short_version": "2.5.0",
  "java_version": "java-1.8.0-openjdk",
  "vm_mem": 13312,
  "vm_cpus": 8,

  "am_mem": 512,
  "server_mem": 768,
  "client_mem": 1024,

  "security": true,
  "domain": "example.com",
  "realm": "EXAMPLE.COM",

  "clients" : [ "hdfs", "hive", "hive2", "odbc", "slider", "tez", "yarn", "zk" ],
  "nodes": [
    {"hostname": "llapsecure", "ip": "192.168.59.12",
     "roles": ["client", "hive-db", "hive-meta",
               "hive2", "hive2-llap", "hive2-server2",
               "httpd", "kdc", "nn", "slave", "tez-ui",
               "yarn", "yarn-timelineserver", "zk"]}
  ],

  "hive_options" : "interactive",

  "extras": [ "sample-hive-data" ]
}
