node default {
  class { 'php': }
  class { 'apache':
    mpm_module => 'prefork',
    user => 'vagrant',
    group => 'vagrant',
  }
  include apache::mod::php
  include apache::mod::rewrite

  php::module {  "curl": }
  php::module {  "mysql": }
  php::module {  "xdebug": }

  apache::vhost { 'www.zendbare.lo':
    port    => 80,
    docroot => '/vagrant/app/public',
  }

  class { '::mysql::server':
    root_password => 'o4o4'
  }

  mysql::db { 'zend':
    user     => 'zend_user',
    password => 'zendo4o4',
  }

  file { 'xdebug':
    path    => '/etc/php5/apache2/conf.d/20-xdebug.ini',
    ensure  => '/vagrant/resources/xdebug.ini',
    require => Class['php'],
    notify  => Service['apache2'],
  }

}
