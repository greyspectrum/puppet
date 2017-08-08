# execute 'yum update'
exec { 'yum update':
  command => '/usr/bin/yum update'
}

# install httpd package
package { 'httpd':
  require => Exec['yum update'],
  ensure => installed,
}

# ensure httpd service is running
service { 'httpd':
  ensure => running,
}

# install mariadb package
package { 'mariadb-server':
  require => Exec['yum update'],
  ensure => installed,
}

# ensure mariadb service is running
service { 'mariadb':
  ensure => running,
}

# install php
package { 'php':
  require => Exec['yum update'],
  ensure => installed,
}

# install php-mysql
package { 'php-mysql':
  require => Exec['yum update'],
  ensure => installed,
}

# ensure info.php file exists
file { '/var/www/html/info.php':
  ensure => file,
  content => '<?php phpinfo(); ?>',
  require => Package['httpd'],
}

