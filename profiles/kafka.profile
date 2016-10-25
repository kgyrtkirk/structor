{
  "os": "centos7",
  "hdp_short_version": "2.6.0",
  "vm_mem": 8192,
  "vm_cpus": 4,

  "am_mem": 512,
  "server_mem": 768,
  "client_mem": 1024,

  "security": false,
  "domain": "example.com",
  "realm": "EXAMPLE.COM",

  "clients" : [ "hdfs", "spark", "zk" ],
  "nodes": [
    {"hostname": "kafka", "ip": "192.168.59.31",
     "roles": ["client", "httpd", "kafka", "nn", "slave", "zk"]}
  ]
}
