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

class druid_overlord {
  require druid_base
  $path="/bin:/sbin:/usr/bin:/usr/sbin"

  # Configuration files.
  $component="overlord"
  file { "/etc/druid/conf/$component/jvm.config":
    ensure => file,
    content => template("druid_$component/jvm.config.erb"),
    before => Service["druid-$component"],
  }

  # Link.
  exec { "hdp-select set druid-overlord ${hdp_version}":
    cwd => "/",
    path => "$path",
    before => Service["druid-overlord"],
  }

  # Startup.
  if ($operatingsystem == "centos" and $operatingsystemmajrelease == "7") {
    file { "/etc/systemd/system/druid-overlord.service":
      ensure => 'file',
      source => "/vagrant/files/systemd/druid-overlord.service",
      before => Service["druid-overlord"],
    }
  }
  service { 'druid-overlord':
    ensure => running,
    enable => true,
  }

  # Samples.
  file { "/home/vagrant/wikiticker-hdfs":
    ensure => directory,
    owner => vagrant,
    group => vagrant,
  } ->
  file { "/home/vagrant/wikiticker-hdfs/wikitickerHdfsIndex.sh":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    content => template("druid_overlord/wikitickerHdfsIndex.sh.erb"),
  } ->
  file { "/home/vagrant/wikiticker-hdfs/wikiticker-index-hdfs.json":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    source => "puppet:///modules/druid_overlord/wikiticker-index-hdfs.json",
  } ->
  file { "/home/vagrant/wikiticker-hdfs/sampleDruidQuery.sh":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    source => "puppet:///modules/druid_overlord/sampleDruidQuery.sh",
  } ->
  file { "/home/vagrant/wikiticker-hdfs/TimeBoundaryQuery.json":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    source => "puppet:///modules/druid_overlord/TimeBoundaryQuery.json",
  } ->
  file { "/home/vagrant/wikiticker-hdfs/TimeSeriesQuery.json":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    source => "puppet:///modules/druid_overlord/TimeSeriesQuery.json",
  }

  file { "/home/vagrant/druid-tpch":
    ensure => directory,
    owner => vagrant,
    group => vagrant,
  } ->
  file { "/home/vagrant/druid-tpch/indexTpch.sh":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    content => template("druid_overlord/indexTpch.sh.erb"),
  } ->
  file { "/home/vagrant/druid-tpch/tpch-index-hdfs.json":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    source => "puppet:///modules/druid_overlord/tpch-index-hdfs.json",
  }

  file { "/home/vagrant/sampleWeblog.sh":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    content => template("druid_overlord/sampleWeblog.sh.erb"),
  }

  file { "/home/vagrant/wikiticker-kafka":
    ensure => directory,
    owner => vagrant,
    group => vagrant,
  } ->
  file { "/home/vagrant/wikiticker-kafka/wikiticker-kafka-supervisor-spec.json":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    content => template("druid_overlord/wikiticker-kafka-supervisor-spec.json.erb"),
  } ->
  file { "/home/vagrant/wikiticker-kafka/wikitickerKafkaSupervisor.sh":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    content => template("druid_overlord/wikitickerKafkaSupervisor.sh.erb"),
  } ->
  file { "/home/vagrant/wikiticker-kafka/wikitickerKafkaDemo.sh":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    content => template("druid_overlord/wikitickerKafkaDemo.sh.erb"),
  } ->
  file { "/home/vagrant/wikiticker-kafka/hive_integration_setup.sh":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    source => "puppet:///modules/druid_overlord/hive_integration_setup.sh",
  } ->
  file { "/home/vagrant/wikiticker-kafka/hive_integration_servers.sh":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    source => "puppet:///modules/druid_overlord/hive_integration_servers.sh",
  }
}
