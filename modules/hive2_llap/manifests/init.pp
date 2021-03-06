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

class hive2_llap {
  require hive2
  require slider

  $path="/bin:/usr/bin:/usr/sbin"

  if $security == "true" {
    require load_hive_keytab
  }

  file { "/home/vagrant/start_llap.sh":
    ensure => "file",
    source => 'puppet:///modules/hive2_llap/start_llap.sh',
    owner => vagrant,
    group => vagrant,
    mode => '755',
  }

  # LLAP Sizing:
  # LLAP will take up all YARN memory minus 1 GB (including Slider AM overhead of 0.5 GB)
  #   First: Try to set number of executors = number of CPUs - 2.
  #   If we have memory left over, we take the rest up with cache.
  #   Note this only allows 2 concurrent queries (2 AMs)
  if ($vm_mem+0 <= 2048) {
    $yarn_total = $vm_mem - 1024
  } elsif ($vm_mem+0 <= 8192) {
    $yarn_total = $vm_mem - 2048
  } else {
    $yarn_total = $vm_mem - 4096
  }

  $max_queries = 2
  $am_size = $am_mem+0
  $slider_am_overhead = 512
  $extra_allowance = 512
  $gc_anti_slop = 512
  if ($vm_cpus+0 == 8) {
    $num_executors = $vm_cpus-3
  } else {
    $num_executors = $vm_cpus-2
  }
  $total_am_overhead       = ($am_size * $max_queries) + $slider_am_overhead
  $full_executor_allotment = ($client_mem+0) * $num_executors
  $llap_yarn_size          = $yarn_total - $total_am_overhead
  if ($full_executor_allotment > $llap_yarn_size) {
    fail("Can't satisfy this VM configuration, need more memory")
  }
  $cache_size = $llap_yarn_size - $full_executor_allotment - $extra_allowance
  $xmx_size   = $full_executor_allotment - $gc_anti_slop

  # Extra security related setup.
  if $security == "true" {
    # Deal with slider overhead. XXX: Realm is hardcoded.
    $security_args = "--slider-keytab hive.headless.keytab --slider-keytab-dir .slider/keytabs/hive --slider-principal hive@EXAMPLE.COM"
    exec { "Create headless Hive principal for Slider":
      command => "kadmin.local -q 'addprinc -randkey hive@EXAMPLE.COM'",
      cwd => "/etc/security/hadoop",
      path => $path,
    } ->
    exec { "Generate extra keytab for slider":
      command => 'kadmin.local -q "xst -norandkey -k hive.headless.keytab hive@EXAMPLE.COM"',
      cwd => "/etc/security/hadoop",
      path => $path,
      creates => "/etc/security/hadoop/hive.headless.keytab",
    } ->
    file { "/etc/security/hadoop/hive.headless.keytab":
      ensure => file,
      owner => hive,
      group => hadoop,
      mode => '400',
    } ->
    exec { "Install extra slider keytab":
      command => "slider install-keytab --keytab hive.headless.keytab --folder hive --overwrite",
      cwd => "/etc/security/hadoop",
      path => $path,
      user => "hive",
    }
  } else {
    $security_args = ""
  }

  # Build a package.
  $extra_args="-XX:+UseG1GC -XX:TLABSize=8m -XX:+ResizeTLAB -XX:+UseNUMA -XX:+AggressiveOpts -XX:+AlwaysPreTouch -XX:InitiatingHeapOccupancyPercent=80 -XX:MaxGCPauseMillis=200 -XX:HeapDumpPath=/tmp/llap.hprof -XX:-HeapDumpOnOutOfMemoryError"
  exec { "Eliminate old Slider package":
    command => "rm -rf /usr/hdp/llap-slider",
    path => $path,
  }
  ->
  exec { "Build LLAP package":
    command => "hive2 --service llap --instances 1 --cache ${cache_size}m --executors ${num_executors} --size ${llap_yarn_size}m --xmx ${xmx_size}m --loglevel WARN --slider-am-container-mb 512 $security_args --args \"$extra_args\"",
    cwd => "/tmp",
    path => $path,
    user => "hive",
  }
  ->
  exec { "Rename LLAP package output to something guessable":
    command => "mv /tmp/llap-slider-* /usr/hdp/llap-slider",
    path => $path,
  }
  ->
  exec { "Make run.sh executable":
    command => "chmod 755 /usr/hdp/llap-slider/run.sh",
    path => $path,
  }

  # Control script.
  # XXX: Don't even know if this is possible.
}
