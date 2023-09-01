# Class: jenkins::repo::debian
#
class jenkins::repo::debian
{
  include ::stdlib
  include ::apt
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  $pkg_host = 'https://pkg.jenkins.io'

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
      notify   => Exec['apt_update'],
    }
  }
}
