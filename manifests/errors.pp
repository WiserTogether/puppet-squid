class squid::errors {
  file {"/etc/squid/errors":
    ensure => directory,
    source => "puppet:///squid/errors",
    recurse => true,
    require => Package["squid"],
  }

  squid::conf {"error_directory":
    ensure => "/etc/squid/errors"
  }
}
