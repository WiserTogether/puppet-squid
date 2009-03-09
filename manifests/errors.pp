class squid::errors {
  file {"/etc/squid/errors":
    ensure => directory,
    source => "puppet:///squid/errors",
    recurse => true,
  }

  squid::conf {"error_directory":
    changes => "set error_directory /etc/squid/errors"
  }
}
