# Jenkins Profile
class profile::jenkins {

  class {'jenkins': lts => true }

  package {'git': ensure => latest }

  file {'/tmp/pdk.rpm':
    ensure => file,
    source => 'https://puppet-pdk.s3.amazonaws.com/pdk/1.7.0.0/repos/el/7/puppet5/x86_64/pdk-1.7.0.0-1.el7.x86_64.rpm',
  }

# Install latest PDK directly from Puppet Source
  package {'pdk':
    ensure  => installed,
    source  => '/tmp/pdk.rpm',
    require => File['/tmp/pdk.rpm'],
  }

}
