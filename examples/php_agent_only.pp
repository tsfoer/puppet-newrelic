node default {

  class { '::newrelic::agent::php':
    license_key  => '3522b44f4c3f89c8566d5781bac6e0bb7dedab7z',
    ini_settings => {
      'appname'     => "Test Application: ${facts[networking][hostname]}",
      'daemon.port' => '60666',
    },
  }

}
