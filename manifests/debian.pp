class squid::debian inherits squid::base {
    File["squid_config"] {
        source => undef
    }

    Service["squid"] {
        restart => "/etc/init.d/squid reload",
    } 
}
