# == Class: ttrss::service
#
#    This class should not be called directly.
#

class ttrss::service {

  file { '/etc/systemd/system/ttrss.service':
    ensure  => file,
    content => template('ttrss/ttrss.service.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  service { 'ttrss':
    ensure  => $ttrss::enable_update_daemon,
    enable  => true,
    require => File['/etc/systemd/system/ttrss.service'],
  }

}
