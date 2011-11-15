define squid::conf ($ensure) {
    squid::augeas {$name:
        changes   => $ensure ? {
          absent  => "rm ${name}",
          default => "set '${name}' '${ensure}'",
        }
    }
}
