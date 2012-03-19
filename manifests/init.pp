# modules/squid/manifests/init.pp - manage squid stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "squid": }

class squid { 
    case $operatingsystem {
        gentoo: { include squid::gentoo }
        centos,redhat: { include squid::centos }
        debian: { include squid::debian}
        default: { include squid::base }
    }

    if $use_munin {
        include squid::munin
    }
}
