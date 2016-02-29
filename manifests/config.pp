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
  $dbport               = $::ttrss::dbport
  $enable_update_daemon = $::ttrss::enable_update_daemon
  $single_user_mode     = $::ttrss::single_user_mode
  $ttrssurl             = $::ttrss::ttrssurl
  $webroot              = $::ttrss::webroot
  $dirname              = $::ttrss::dirname
  $webserver_user       = $::ttrss::webserver_user
  $webserver_group      = $::ttrss::webserver_group

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
    mode    => '0444',
    owner   => $webserver_user,
    group   => $webserver_group,
  }

  package { $php_db_package:
    ensure => 'present',
  }
}
