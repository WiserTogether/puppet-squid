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
