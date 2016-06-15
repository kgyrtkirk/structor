{
  "ambari_version": "2.4.0.0",
  "wtf": "YFW Ambari never bothered to fix compatibility with OpenJDK 7",
  "java_version": "java-1.8.0-openjdk",
  "vm_mem": 10240,
  "vm_cpus": 8,

  "am_mem": 512,
  "server_mem": 768,
  "client_mem": 1024,

  "security": false,
  "domain": "example.com",
  "realm": "EXAMPLE.COM",

  "clients" : [ ],
  "nodes": [
    {"hostname": "ambari4", "ip": "192.168.59.41", "roles": ["ambari-server"]}
  ]
}
