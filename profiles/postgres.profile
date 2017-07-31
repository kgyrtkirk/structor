{
  "os": "centos7",
  "hdp_short_version": "2.5.0",
  "java_version": "java-1.8.0-openjdk",
  "vm_mem": 1024,
  "vm_cpus": 4,

  "am_mem": 512,
  "server_mem": 768,
  "client_mem": 1024,

  "security": false,
  "domain": "example.com",
  "realm": "EXAMPLE.COM",

  "clients" : [ "odbc" ],
  "nodes": [
    {"hostname": "postgres", "ip": "192.168.59.100",
     "roles": ["client", "nn", "postgres", "slave"]}
  ]
}
