control 'Jenkins Status' do
  describe package('jenkins') do
    it { is_expected.to be_installed }
  end

  describe http('http://localhost:8080', open_timeout: 60, read_timeout: 60) do
    its('status') { is_expected.to cmp 200 }
  end

  describe service('jenkins') do
    it { is_expected.to be_running }
  end
end
