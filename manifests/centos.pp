class squid::centos inherits squid::base {
    file{'/etc/sysconfig/squid':
        source => [ "puppet:///modules/squid/sysconfig/squid", ],
        require => Package['squid'],
        notify => Service['squid'],
        owner => root, group => 0, mode => '0644';
    }
}
