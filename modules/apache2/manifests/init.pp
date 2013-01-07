class apache2 {
  package { "apache2":
    ensure  => present,
    before  => File["/etc/apache2/apache2.conf"],
  }
  service { "apache2":
    ensure    => true,
    enable    => true,
    subscribe => [File["/etc/apache2/apache2.conf"], File["/etc/apache2/sites-enabled/onruby.conf"], File["/usr/local/bin/hor_ruby_wrapper_script"]],
    require   => Exec[install_passenger],
  }
  file { "/etc/apache2/apache2.conf":
    source => "puppet:///modules/apache2/apache2.conf",
  }
  file { "/etc/apache2/sites-enabled/onruby.conf":
    source  => "puppet:///modules/apache2/onruby.conf",
  }
  exec { "delete-default":
    onlyif  => "ls /etc/apache2/sites-enabled/000-default",
    command => "rm /etc/apache2/sites-enabled/000-default",
    user    => root,
    before  => Service[apache2],
  }
}
