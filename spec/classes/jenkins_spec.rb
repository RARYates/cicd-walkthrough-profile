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
      let :facts do
        os_facts.merge(systemd_fact)
      end

      it { is_expected.to compile }
    end
  end
end
