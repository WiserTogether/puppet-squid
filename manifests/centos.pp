class squid::centos inherits squid::base {
    file{'/etc/sysconfig/squid':
        source => [ "puppet://$server/files/squid/sysconfig/${fqdn}/squid",
                    "puppet://$server/files/squid/sysconfig/squid",
                    "puppet://$server/squid/sysconfig/squid" ],
        require => Package['squid'],
        notify => Service['squid'],
        owner => root, group => 0, mode => '0644';
    }
}
