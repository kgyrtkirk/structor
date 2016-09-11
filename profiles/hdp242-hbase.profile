{
  "hdp_short_version": "2.4.2",
  "os": "centos7",
  "java_version": "java-1.8.0-openjdk",
  "vm_mem": 6144,
  "vm_cpus": 4,

  "am_mem": 512,
  "server_mem": 768,
  "client_mem": 1024,

  "security": false,
  "domain": "example.com",
  "realm": "EXAMPLE.COM",

  "clients" : [ "hbase", "hdfs", "yarn", "zk"],
  "nodes": [
    {"hostname": "hdp242-hbase", "ip": "192.168.59.11",
     "roles": ["client", "hbase-master", "hbase-regionserver",
               "httpd", "nn", "slave", "yarn", "zk"]}
  ]
}
