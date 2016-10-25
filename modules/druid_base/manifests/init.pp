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

class druid_base {
  require zookeeper_client

  # Install Node.
  exec { "curl --silent --location https://rpm.nodesource.com/setup_4.x | sudo bash -":
    cwd => "/",
    path => "$path",
    creates => "/etc/yum.repos.d/nodesource-el.repo",
  }
  ->
  package { "nodejs" :
    ensure => installed,
  }

  # Install Druid.
  package { "druid${package_version}":
    ensure => installed,
  }

  # Work around some bugs for now.
  file { "/usr/hdp/${hdp_version}/druid/bin/node.sh":
    ensure => file,
    source => 'puppet:///modules/druid_base/node.sh',
  } ->
  file { "/usr/hdp/${hdp_version}/druid/conf/druid/_common/common.runtime.properties":
    ensure => file,
    content => template('druid_base/common.runtime.properties.erb'),
  } ->
  file { "/usr/hdp/${hdp_version}/druid/var":
    ensure => directory,
    owner => "druid",
    group => "druid",
  } ->
  file { "/usr/hdp/${hdp_version}/druid/var/druid":
    ensure => directory,
    owner => "druid",
    group => "druid",
  } ->
  file { "/usr/hdp/${hdp_version}/druid/var/tmp":
    ensure => directory,
    owner => "druid",
    group => "druid",
  } ->
  file { "/var/run/druid":
    ensure => "directory",
    owner => "druid",
    group => "druid",
  } ->
  file { "/usr/hdp/${hdp_version}/druid/extensions/druid-hdfs-storage/hadoop-lzo.jar":
    ensure => link,
    target => "/usr/hdp/${hdp_version}/hadoop/lib/hadoop-lzo-0.6.0.${hdp_version}.jar",
  }

  # Copy in the site XMLs.
  # Hope to get rid of this at some point.
  file { "/etc/druid/conf/druid/_common/core-site.xml":
    ensure => file,
    source => '/etc/hadoop/conf/core-site.xml',
  } ->
  file { "/etc/druid/conf/druid/_common/hdfs-site.xml":
    ensure => file,
    source => '/etc/hadoop/conf/hdfs-site.xml',
  } ->
  file { "/etc/druid/conf/druid/_common/mapred-site.xml":
    ensure => file,
    source => '/etc/hadoop/conf/mapred-site.xml',
  } ->
  file { "/etc/druid/conf/druid/_common/yarn-site.xml":
    ensure => file,
    source => '/etc/hadoop/conf/yarn-site.xml',
  }
}
