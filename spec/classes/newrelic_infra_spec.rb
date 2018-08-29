require 'spec_helper'

describe 'newrelic::infra', 'type' => 'class' do
  let(:facts) do
    {
      'os' => {
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
      'license_key' => '1234567890qwerty',
    }
  end

  it { is_expected.to compile }
  it { is_expected.to contain_package('newrelic-infra') }
  it { is_expected.to contain_service('newrelic-infra').that_requires('Package[newrelic-infra]') }
  it { is_expected.to contain_file('/etc/newrelic-infra.yml').with_content("license_key: 1234567890qwerty\n") }

  context 'with manage_repo => true' do
    let(:params) do
      super().merge('manage_repo' => true)
    end

    it { is_expected.to contain_class('newrelic::repo::infra') }
  end
end
