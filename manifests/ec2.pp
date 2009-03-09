class squid::ec2 {
  file {"/mnt/squid":
    ensure => directory,
    owner  => "proxy",
    group  => "proxy",
  }

  squid::conf {"cache_dir":
    ensure  => "ufs /mnt/squid 100000 16 256",
    require => File["/mnt/squid"],
  }
}
