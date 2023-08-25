# Class: jenkins::repo::debian
#
class jenkins::repo::debian
{
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  include stdlib
  include apt

  if $::jenkins::lts  {
    apt::source { 'jenkins':
      location    => 'https://pkg.jenkins.io/debian-stable',
      release     => 'binary/',
      repos       => '',
      key         => '63667EE74BBA1F0A08A698725BA31D57EF5975CA',
      key_source  => 'https://pkg.jenkins.io/debian/jenkins.io.key',
      include_src => false,
    }
  }
  else {
    apt::source { 'jenkins':
      location    => 'https://pkg.jenkins.io/debian',
      release     => 'binary/',
      repos       => '',
      key         => '63667EE74BBA1F0A08A698725BA31D57EF5975CA',
      key_source  => 'https://pkg.jenkins.io/debian/jenkins.io.key',
      include_src => false,
    }
  }

  anchor { 'jenkins::repo::debian::begin': } ->
    Apt::Source['jenkins'] ->
    anchor { 'jenkins::repo::debian::end': }
}
