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

class druid_realtime {
  require druid_base

  # Configuration files.
  $component="realtime"
  file { "/etc/druid/conf/druid/$component":
    ensure => directory,
    owner => "root",
    group => "root",
  } ->
  file { "/etc/druid/conf/druid/$component/jvm.config":
    ensure => file,
    content => template("druid_$component/jvm.config.erb"),
  } ->
  file { "/etc/druid/conf/druid/$component/realtime.spec":
    ensure => file,
    content => template("druid_$component/realtime.spec.erb"),
  } ->
  file { "/etc/druid/conf/druid/$component/runtime.properties":
    ensure => file,
    content => template("druid_$component/runtime.properties.erb"),
  }

  # Fixes / workarounds.
  file { "/usr/hdp/current/druid-realtime":
    ensure => link,
    target => "/usr/hdp/${hdp_version}/druid",
  } ->
  file { "/usr/hdp/current/druid-realtime/bin/realtime.sh":
    ensure => file,
    mode => "755",
    source => 'puppet:///modules/druid_realtime/realtime.sh',
  }

  # Samples / demos.
  file { "/home/vagrant/sampleDruidRealtimeQuery.sh":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    content => template("druid_realtime/sampleDruidRealtimeQuery.sh.erb"),
  }

  # Startup.
  if ($operatingsystem == "centos" and $operatingsystemmajrelease == "7") {
    file { "/etc/systemd/system/druid-realtime.service":
      ensure => 'file',
      source => "/vagrant/files/systemd/druid-realtime.service",
    }
  }
}
