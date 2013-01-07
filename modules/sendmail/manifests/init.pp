class sendmail {
  package { "sendmail":
    ensure  => present,
  }
  service { "sendmail":
    ensure    => true,
    enable    => true,
  }
  # file { "/etc/apache2/conf.d/passenger.conf":
  #   source  => "puppet:///modules/passenger/passenger.conf",
  #   alias   => "passenger_conf",
  #   notify  => Service[apache2],
  # }
}
