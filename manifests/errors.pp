class squid::errors {
  file {"/etc/squid/errors":
    ensure => directory,
    source => "puppet:///modules/squid/errors",
    recurse => true,
    owner   => "root",
    group   => "root",
    mode    => 644,
    require => Package["squid"],
  }

  squid::conf {"error_directory":
    ensure => "/etc/squid/errors"
  }
}
