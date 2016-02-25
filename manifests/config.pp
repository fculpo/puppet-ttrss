# == Class: ttrss::config
#
#    This class should not be called directly.
#

class ttrss::config {

  $dbname               = $::ttrss::dbname
  $dbusername           = $::ttrss::dbusername
  $dbpassword           = $::ttrss::dbpassword
  $dbserver             = $::ttrss::dbserver
  $dbtype               = $::ttrss::dbtype
  $enable_update_daemon = $::ttrss::enable_update_daemon
  $single_user_mode     = $::ttrss::single_user_mode
  $ttrssurl             = $::ttrss::ttrssurl
  $webroot              = $::ttrss::webroot
  $dirname              = $::ttrss::dirname
  $webserver_user       = $::ttrss::webserver_user

  if ! $dbname {
    fail('No database name specified.')
  }

  if ! $dbusername {
    fail('No database username specified.')
  }

  if ! $dbpassword {
    fail('No database password specified.')
  }

  if ! $dbserver {
    fail('No database server specified.')
  }

  case $dbtype {
    'mysql': { $php_db_package = 'php-mysql' }
    'pgsql': { $php_db_package = 'php-pgsql' }
    default: { fail("Valid database backend required, found '${dbtype}'") }
  }

  file { "$webroot/$dirname/config.php":
    ensure  => file,
    content => template('ttrss/config.php.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  file { "$webroot/$dirname/database.php":
    ensure  => file,
    content => template('ttrss/database.php.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => "$webserver_user",
  }

  package { $php_db_package:
    ensure => 'present',
  }
}
