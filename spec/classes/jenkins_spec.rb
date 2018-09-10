require 'spec_helper'

describe 'profile::jenkins' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      systemd_fact = case os_facts[:operatingsystemmajrelease]
                     when '6'
                       { systemd: false }
                     else
                       { systemd: true }
                     end
      root_home = { root_home: '/root' }
      let :facts do
        os_facts.merge(**systemd_fact, **root_home)
      end

      ####  NEW CODE  ####

      context 'With Defaults' do
        it do
          # Jenkins must be the LTS
          is_expected.to contain_class('jenkins').with('lts' => 'true')

          # We're unsure if we want latest git, but we want to make sure it's installed
          is_expected.to contain_package('git')

          # Download this particular version of the PDK
          is_expected.to contain_file('/tmp/pdk.rpm').with('ensure' => 'file',
                                                           'source' => 'https://puppet-pdk.s3.amazonaws.com/pdk/1.7.0.0/repos/el/7/puppet5/x86_64/pdk-1.7.0.0-1.el7.x86_64.rpm')

          # Install PDK from Disk. We'll change this test if we place this in a proper yumrepo one day
          # Also not that that_requires, and  the lack of quotes within the File array
          is_expected.to contain_package('pdk').with('ensure'  => 'installed',
                                                     'source'  => '/tmp/pdk.rpm').that_requires('File[/tmp/pdk.rpm]')
        end
      end

      ### END NEW CODE ###

      it { is_expected.to compile }
    end
  end
end
