class squid::base {
    package { 'squid':
        ensure => present,
    }

    service{'squid':
        enable => true,
        ensure => running,
        hasstatus => true,
        require => Package[squid],
    }

    file {"squid_config":
        path => "/etc/squid/squid.conf",
        ensure => file, owner => root, group => root, mode => 644,
        source => [ "puppet://$server/files/squid/${fqdn}/squid.conf",
                    "puppet://$server/files/squid/squid.conf",
                    "puppet://$server/squid/squid.conf" ],
        notify => Service[squid],
        require => Package["squid"],
    }

    # Up to date augeas lens
    file {"/etc/squid/squid.aug":
      ensure => present,
      source => "puppet:///modules/squid/squid.aug",
    }
}
