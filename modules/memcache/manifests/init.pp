class memcache {
  package { "memcached":
    ensure => present,
    before => Service[memcached],
  }
  service { "memcached":
    ensure    => true,
    enable    => true,
    subscribe => File["/etc/memcached.conf"]
  }
  file { "/etc/memcached.conf":
    source => "puppet:///modules/memcache/memcached.conf",
  }
}
