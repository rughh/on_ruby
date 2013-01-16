class apache2 {
  package { "apache2":
    ensure  => present,
    before  => File["/etc/apache2/apache2.conf"],
  }
  service { "apache2":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    subscribe  => [
      File["/etc/apache2/apache2.conf"],
      File["/etc/apache2/sites-enabled/onruby.conf"],
      File["/usr/local/bin/hor_ruby_wrapper_script"]
    ],
    require    => Exec[install_passenger],
  }
  file { "/etc/apache2/apache2.conf":
    ensure => present,
    source => "puppet:///modules/apache2/apache2.conf",
  }
  file { "/etc/apache2/sites-enabled/onruby.conf":
    ensure => present,
    source => "puppet:///modules/apache2/onruby.conf",
  }
  file { "/etc/apache2/sites-enabled/000-default":
    ensure => absent,
    before => Service["apache2"];
  }
}
