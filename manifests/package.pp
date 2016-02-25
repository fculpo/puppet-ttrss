# == Class: ttrss::package
#
#  This class shouldn't be called directly
#
class ttrss::package {

  $webroot        = $::ttrss::webroot
  $dirname        = $::ttrss::dirname
  $webserver_user = $::ttrss::webserver_user
/*
  file { "$webroot/$dirname":
    ensure => 'directory',
    owner  => root,
    group  => $webserver_user,
    mode   => '0755', 
  }
*/
  vcsrepo { 'ttrss':
    ensure   => present,
    provider => git,
    path     => "$webroot/$dirname",
    #path     => '/tmp/ttrss',
    #user     => $webserver_user,
    source   => 'https://tt-rss.org/git/tt-rss.git',
    revision => 'master',
  }

}
