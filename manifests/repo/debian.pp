# Class: jenkins::repo::debian
#
class jenkins::repo::debian
{
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  include ::stdlib
  include ::apt

  $pkg_host = 'https://pkg.jenkins.io'

  ensure_packages(['apt-transport-https'])

  if $::jenkins::lts  {
    apt::source { 'jenkins':
      location => "${pkg_host}/debian-stable",
      release  => 'binary/',
      repos    => '',
      include  => {
        'src' => false,
      },
      key      => {
        'id'     => '63667EE74BBA1F0A08A698725BA31D57EF5975CA',
        'source' => "${pkg_host}/debian/jenkins-ci.org.key",
      },
      require  => Package['apt-transport-https'],
      notify   => Exec['apt_update'],
    }
  }
  else {
    apt::source { 'jenkins':
      location => "${pkg_host}/debian",
      release  => 'binary/',
      repos    => '',
      include  => {
        'src' => false,
      },
      key      => {
        'id'     => '63667EE74BBA1F0A08A698725BA31D57EF5975CA',
        'source' => "${pkg_host}/debian/jenkins-ci.org.key",
      },
      require  => Package['apt-transport-https'],
      notify   => Exec['apt_update'],
    }
  }
}
