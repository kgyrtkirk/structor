#  Licensed to the Apache Software Foundation (ASF) under one or more
#   contributor license agreements.  See the NOTICE file distributed with
#   this work for additional information regarding copyright ownership.
#   The ASF licenses this file to You under the Apache License, Version 2.0
#   (the "License"); you may not use this file except in compliance with
#   the License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

class hive2_meta {
  require hive2
  require hive_db

  $path="/bin:/usr/bin"

  if $security == "true" {
    require hive_keytab
  }

  # Startup.
  if ($operatingsystem == "centos" and $operatingsystemmajrelease == "7") {
    file { "/etc/systemd/system/hive2-metastore.service":
      ensure => 'file',
      source => "/vagrant/files/systemd/hive2-metastore.service",
      before => Service["hive2-metastore"],
    }
  } else {
    file { "/etc/init.d/hive2-metastore":
      ensure => 'link',
      target => "/usr/hdp/current/hive-server2-hive2/hive2-metastore",
      before => Service["hive2-metastore"],
    }
  }

  exec { "Hive 2 Schema":
    command => "/usr/hdp/current/hive-server2-hive2/bin/schematool -dbType mysql -initSchema",
    user => "hive",
    cwd => "/",
    unless => '/usr/bin/test ! -f /usr/hdp/current/hive-server2-hive2/bin/schematool || /usr/hdp/current/hive-server2-hive2/bin/schematool -dbType mysql -info',
  } ->
  file { "/usr/hdp/current/hive-server2-hive2/hive2-metastore":
    ensure => file,
    mode   => '755',
    source => 'puppet:///modules/hive2_meta/hive2-metastore',
    before => Service["hive2-metastore"],
  } ->
  service { 'hive2-metastore':
    ensure => running,
    enable => true,
  }
}
