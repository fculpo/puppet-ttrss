# == Class: ttrss::package
#
#  This class shouldn't be called directly
#
class ttrss::package {

  $webroot         = $::ttrss::webroot
  $dirname         = $::ttrss::dirname
  $webserver_user  = $::ttrss::webserver_user
  $webserver_group = $::ttrss::webserver_group

  vcsrepo { 'ttrss':
    ensure   => present,
    provider => git,
    path     => "${webroot}/${dirname}",
    source   => 'https://tt-rss.org/git/tt-rss.git',
    revision => 'master',
    owner    => $webserver_user,
    group    => $webserver_group
  } ->

  file { [ "${webroot}/${dirname}/cache/images", 
           "${webroot}/${dirname}/cache/js", 
           "${webroot}/${dirname}/cache/export",
           "${webroot}/${dirname}/cache/upload",
           "${webroot}/${dirname}/feed-icons",
           "${webroot}/${dirname}/lock" ] :
    ensure  => directory,
    mode    => '0775',
    owner   => $webserver_user,
    group   => $webserver_group
  }

}