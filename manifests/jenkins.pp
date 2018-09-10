# Jenkins Profile
class profile::jenkins {

  class {'jenkins':
    lts         => true,
  }

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

  if $::virtual != 'docker' {
    class {'docker':
      docker_users => ['jenkins']
    }
  }

  file_line { 'jenkins_sudo':
    path => '/etc/sudoers',
    line => 'jenkins   ALL=NOPASSWD: /usr/local/rvm/gems/ruby-2.4.1/bin/kitchen',
  }

  include rvm

  rvm::system_user { 'jenkins':}

  rvm_system_ruby {'ruby-2.4.1':
    ensure      => 'present',
    default_use => true,
  }

  rvm_gem {['ruby-2.4.1/librarian-puppet',
            'ruby-2.4.1/test-kitchen',
            'ruby-2.4.1/executable-hooks',
            'ruby-2.4.1/kitchen-inspec',
            'ruby-2.4.1/kitchen-puppet',
            'ruby-2.4.1/kitchen-docker']:
    ensure  => installed,
    require => Rvm_system_ruby['ruby-2.4.1'],
    notify  => Service['jenkins'],
  }

}
