# == Class: ttrss
#
# Sets up ttrss with a set of rules.
#

class ttrss(
    $dbname               = $::ttrss::params::dbname,
    $dbusername           = $::ttrss::params::dbusername,
    $dbpassword           = $::ttrss::params::dbpassword,
    $dbserver             = $::ttrss::params::dbserver,
    $dbtype               = $::ttrss::params::dbtype,
    $dbport               = $::ttrss::params::dbport,
    $enable_update_daemon = $::ttrss::params::enable_update_daemon,
    $single_user_mode     = $::ttrss::params::single_user_mode,
    $ttrssurl             = $::ttrss::params::ttrssurl,
    $webroot              = $::ttrss::params::webroot,
    $dirname              = $::ttrss::params::dirname,
    $webserver_user       = $::ttrss::params::webserver_user,
    $webserver_group      = $::ttrss::params::webserver_group
) inherits ttrss::params {

  anchor { 'ttrss::begin':   } ->
  class  { 'ttrss::package': } ->
  class  { 'ttrss::config':  } 
  class  { 'ttrss::service': } ->
  anchor { 'ttrss::end':     }

  Anchor['ttrss::begin']  ~> Class['ttrss::service']
  Class['ttrss::package'] ~> Class['ttrss::service']
  Class['ttrss::config']  ~> Class['ttrss::service']
}
