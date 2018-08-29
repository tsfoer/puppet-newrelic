require 'spec_helper'

describe 'newrelic::server::linux', type: :class do
  let(:facts) do
    {
      'path' => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin:/snap/bin:/opt/puppetlabs/bin/',
      'os'   => {
        'family'  => 'RedHat',
        'name'    => 'CentOS',
        'release' => {
          'major' => '7',
        },
      },
    }
  end

  let(:params) do
    {
      license_key: '1234567890qwerty',
    }
  end

  it { is_expected.to compile }
  it { is_expected.to contain_class('newrelic::repo::legacy') }
  it { is_expected.to contain_service('newrelic-sysmond') }
  it { is_expected.to contain_package('newrelic-sysmond') }
  it { is_expected.to contain_file('/var/log/newrelic') }
  it { is_expected.to contain_file('/etc/newrelic/nrsysmond.cfg') }
  it { is_expected.to contain_exec('install_newrelic_license_key') }

  context 'with manage_repo => true' do
    let(:params) do
      super().merge('manage_repo' => true)
    end

    it { is_expected.to contain_class('newrelic::repo::legacy') }
  end
end
