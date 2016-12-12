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

class atscale {
  $path="/sbin:/usr/sbin:/bin:/usr/bin"

  package { "rsync":
    ensure => installed,
  } ->
  exec { "AtScale Unzip":
    command => "yum install -y unzip",
    cwd => "/tmp",
    path => "$path",
  } ->
  exec { "Add AtScale User":
    command => "useradd atscale",
    cwd => "/tmp",
    path => "$path",
    unless => "id -u atscale",
  } ->
  exec { "AtScale HDFS Directory":
    command => "hdfs dfs -mkdir -p /user/atscale/atscale",
    user => 'hdfs',
    path => "$path",
  } ->
  exec { "AtScale HDFS Mode":
    command => "hdfs dfs -chown atscale:atscale /user/atscale /user/atscale/atscale",
    user => 'hdfs',
    path => "$path",
  } ->
  file { "/usr/local/atscale":
    ensure => 'directory',
    owner => 'atscale',
    group => 'atscale',
    mode => '755',
  } ->
  exec { "Extract AtScale Bundle":
    command => "tar -zxf /vagrant/modules/atscale/files/atscale-latest-el6.x86_64.tar.gz",
    cwd => "/tmp",
    path => "$path",
  } ->
  exec { "Fix AtScale Ownership":
    command => "chown -R atscale:atscale atscale-*",
    cwd => "/tmp",
    path => "$path",
  } ->
  exec { "Link to AtScale version":
    command => "ln -sf atscale-* atscale",
    cwd => "/tmp",
    path => "$path",
  } ->
  tidy { "/tmp/custom.yaml":
  } ->
  exec { "Install AtScale":
    command => "/tmp/atscale/bin/install -c /vagrant/modules/atscale/files/custom.yaml -l /vagrant/modules/atscale/files/atscale-license.json < /vagrant/modules/atscale/files/atscale_answers.txt",
    cwd => "/tmp/atscale",
    environment => "HOME=/home/atscale",
    path => "$path",
    timeout => 1200,
    user => 'atscale',
  }
}
