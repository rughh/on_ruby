class capistrano {
  # ssh key
  # https://github.com/hashicorp/puppet-bootstrap
  group { "deployer":
    ensure  => "present",
    require => User["deployer"],
  }
  user { "deployer":
    ensure     => "present",
    managehome => true,
    shell      => "/bin/bash",
  }
  file { ["/var/onruby/", "/var/onruby/shared/", "/var/onruby/shared/config"]:
    ensure => directory,
    owner  => deployer,
    group  => deployer,
    mode   => 0755,
  }
  file { "/var/onruby/shared/config/database.yml":
    source => "puppet:///modules/capistrano/database.yml",
    ensure => present,
    owner  => deployer,
    group  => deployer,
    mode   => 0600,
  }
  file { "/home/deployer/.ssh/":
    ensure  => directory,
    owner   => deployer,
    group   => deployer,
    before  => File["/home/deployer/.ssh/authorized_keys"],
    require => User["deployer"],
  }
  file { "/home/deployer/.ssh/authorized_keys":
    source  => "puppet:///modules/capistrano/authorized_keys",
    ensure  => present,
    owner   => deployer,
    group   => deployer,
    mode    => 0600,
  }
  package { "bundler":
    provider => gem,
  }
}
