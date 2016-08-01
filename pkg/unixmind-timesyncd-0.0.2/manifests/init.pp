# Class: timesyncd
# ===========================
#
# Full description of class timesyncd here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'timesyncd':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <Frederic Wou>
#
# Copyright
# ---------
#
# Copyright 2016 Frederic Wou, unless otherwise noted.
#
class timesyncd {
  if $::os['name'] == 'Debian' {
    if $::os['release']['major'] == '8' {

      package { 'ntp_removed':
        name   => 'ntp',
        ensure => 'purged',
      }

      file { 'timesyncd.conf':
        path   => '/etc/systemd/timesyncd.conf',
        ensure => 'file',
        owner  => 'root',
        group  => 'root',
        mode   => 'u=rw,go=r',
        source => 'puppet:///modules/timesyncd/timesyncd.conf_ntp.org',
        notify => Service['systemd-timesyncd'],
      }

      service { 'systemd-timesyncd':
        ensure => 'running',
        enable => 'true',
        require => [ Package['ntp_removed'] , File['timesyncd.conf'] ],
      }

    } else {
      notify { "Debian ${::os['release']['major']} not supported": }
    }
  } else {
    notify { "Operating system ${::os['name']} not supported": }
  }
}
