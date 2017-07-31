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

class spark_thriftserver {
  require spark_client

  if $security == "true" {
    require hive_keytab
  }

  # Config files.
  file { '/usr/hdp/current/spark2-thriftserver/conf/hive-site.xml':
    ensure => file,
    content => template('spark_thriftserver/hive-site.xml.erb'),
  } ->
  file { '/usr/hdp/current/spark2-thriftserver/conf/spark2-defaults.conf':
    ensure => file,
    content => template('spark_thriftserver/spark2-defaults.conf.erb'),
  } ->
  file { '/usr/hdp/current/spark2-thriftserver/conf/java-opts':
    ensure => "file",
    mode => '0644',
    source => 'puppet:///modules/spark_thriftserver/java-opts',
  } ->
  file { '/usr/hdp/current/spark2-thriftserver/conf/log4j.properties':
    ensure => "file",
    mode => '0644',
    source => 'puppet:///modules/spark_thriftserver/log4j.properties',
  } ->
  file { '/usr/hdp/current/spark2-thriftserver/conf/metrics.properties':
    ensure => "file",
    mode => '0644',
    source => 'puppet:///modules/spark_thriftserver/metrics.properties',
  } ->
  file { '/usr/hdp/current/spark2-thriftserver/conf/spark2-env.sh':
    ensure => "file",
    mode => '0644',
    source => 'puppet:///modules/spark_thriftserver/spark2-env.sh',
  } ->
  file { '/usr/hdp/current/spark2-thriftserver/conf/spark2-thrift-fairscheduler.xml':
    ensure => "file",
    mode => '0644',
    source => 'puppet:///modules/spark_thriftserver/spark2-thrift-fairscheduler.xml',
  } ->
  file { '/usr/hdp/current/spark2-thriftserver/conf/spark2-thrift-sparkconf.conf':
    ensure => "file",
    mode => '0644',
    source => 'puppet:///modules/spark_thriftserver/spark2-thrift-sparkconf.conf',
  } ->
  file { '/usr/hdp/current/spark2-thriftserver/conf/spark2-thriftserver':
    ensure => "file",
    mode => '0644',
    source => 'puppet:///modules/spark_thriftserver/spark2-thriftserver',
  } ->
  file { '/var/log/spark':
    ensure => "directory",
    owner => spark,
    group => spark,
  } ->
  service { 'spark-thriftserver':
    ensure => running,
    enable => true,
  }

  # Startup.
  if ($operatingsystem == "centos" and $operatingsystemmajrelease == "7") {
    file { "/etc/systemd/system/spark-thriftserver.service":
      ensure => 'file',
      source => "/vagrant/files/systemd/spark-thriftserver.service",
      before => Service["spark-thriftserver"],
    }
  } else {
    file { "/etc/init.d/spark2-thriftserver":
      ensure => file,
      source => "puppet:///modules/spark_thriftserver/spark-thriftserver",
      mode => '755',
      owner => root,
      group => root,
      replace => true,
      before => Service["spark-thriftserver"],
    }
  }
}
