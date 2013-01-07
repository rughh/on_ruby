class passenger {
  package { "libcurl4-openssl-dev":
    ensure  => present,
  }
  package { "apache2-prefork-dev":
    ensure  => present,
  }
  package { "libapr1-dev":
    ensure  => present,
  }
  package { "libaprutil1-dev":
    ensure  => present,
  }
  exec { "install_passenger":
    user    => root,
    group   => root,
    unless  => "ls /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.18/",
    command => "/usr/local/bin/gem install passenger -v=3.0.18",
    require => Package[apache2, libcurl4-openssl-dev, apache2-prefork-dev, libapr1-dev, libaprutil1-dev],
  }
  exec { "passenger_apache_module":
    user    => root,
    group   => root,
    path    => "/bin:/usr/bin:/usr/local/apache2/bin/",
    unless  => "ls /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.18/ext/apache2/mod_passenger.so",
    command => "/usr/local/bin/passenger-install-apache2-module --auto",
    require => Exec[install_passenger],
  }
  file { "/usr/local/bin/hor_ruby_wrapper_script":
    owner   => root,
    group   => root,
    mode    => 0755,
    before  => File[passenger_conf],
    content => template("passenger/hor_ruby_wrapper_script.erb"),
  }
  file { "/etc/apache2/conf.d/passenger.conf":
    source  => "puppet:///modules/passenger/passenger.conf",
    alias   => "passenger_conf",
    notify  => Service[apache2],
  }
}
