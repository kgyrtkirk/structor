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

class superset {
  $path="/usr/hdp/${hdp_version}/superset/bin:/bin:/usr/bin:/usr/sbin"

  # Install and setup.
  package { "epel-release":
    ensure => installed,
  }
  ->
  package { "superset${package_version}":
    ensure => installed,
  }
  ->
  file { "/usr/hdp/current/superset":
    ensure => link,
    target => "/usr/hdp/${hdp_version}/superset",
    before => Service["superset"],
  }
  ->
  exec { "/usr/hdp/current/superset/bin/fabmanager create-admin --app superset --username admin --password password --firstname admin --lastname user --email nobody@example.com":
    cwd => "/",
    path => "$path",
  }
  ->
  exec { "/usr/hdp/current/superset/bin/superset db upgrade":
    cwd => "/",
    path => "$path",
  }
  ->
  exec { "/usr/hdp/current/superset/bin/superset load_examples":
    cwd => "/",
    path => "$path",
  }
  ->
  exec { "/usr/hdp/current/superset/bin/superset init":
    cwd => "/",
    path => "$path",
    before => Service["superset"],
  }

  # Startup.
  if ($operatingsystem == "centos" and $operatingsystemmajrelease == "7") {
    file { "/etc/systemd/system/superset.service":
      ensure => 'file',
      source => "/vagrant/files/systemd/superset.service",
      before => Service["superset"],
    }
  }

  service { 'superset':
    ensure => running,
    enable => true,
  }
}
