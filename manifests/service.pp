# == Class: ttrss::service
#
#    This class should not be called directly.
#

class ttrss::service {

  $enable_update_daemon = $ttrss::enable_update_daemon

  file { '/etc/systemd/system/ttrss_backend.service':
    ensure  => file,
    content => template('ttrss/default/ttrss.service.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  service { 'tt-rss':
    ensure  => $enable_update_daemon,
    enable  => true,
    require => File['/etc/systemd/system/ttrss_backend.service'],
  }

}
