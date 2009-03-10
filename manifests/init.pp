# modules/squid/manifests/init.pp - manage squid stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "squid": }

class squid { 
    case $operatingsystem {
        gentoo: { include squid::gentoo }
        centos: { include squid::centos }
        debian: { include squid::debian}
        default: { include squid::base }
    }

    if $use_munin {
        include squid::munin
    }
}


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
    }

    # Up to date augeas lens
    file {"/etc/squid/squid.aug":
      ensure => present,
      source => "puppet:///squid/squid.aug",
    }
}

class squid::gentoo inherits squid::base {
    Package[squid]{
        category => 'net-proxy',
    }
}

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

class squid::debian inherits squid::base {
    File["squid_config"] {
      source => undef
    }
}

define squid::augeas ($changes, $onlyif = "") {
    augeas {$name:
        context   => "/files/etc/squid/squid.conf",
        load_path => "/etc/squid",
        changes   => $changes,
        onlyif    => $onlyif,
        notify    => Service["squid"],
        require   => [File["squid_config"], File["/etc/squid/squid.aug"]],
    }
}

define squid::conf ($ensure) {
    squid::augeas {$name:
        changes   => $ensure ? {
          absent  => "rm ${name}",
          default => "set '${name}' '${ensure}'",
        }
    }
}
