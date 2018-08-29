require 'spec_helper'

describe 'newrelic::php::newrelic_ini' do
  let(:title) { '/opt/rh/php54/root/etc/php.d' }

  it { is_expected.to compile }
  it { is_expected.to contain_defines__newrelic__php__newrelic_ini('/opt/rh/php54/root/etc/php.d') }
  it { is_expected.to contain_exec('/usr/bin/newrelic-install /opt/rh/php54/root/etc/php.d') }
  it { is_expected.to contain_file('/opt/rh/php54/root/etc/php.d/newrelic.ini') }
end
