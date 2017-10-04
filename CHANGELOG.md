# Change Log

Release notes for the claranet/puppet-newrelic module.

------------------------------------------

## 2.0.1 - 2017-10-04
  * Infra Repo: Apt module now handles setting `release` for Debian osfamily - [#11](https://github.com/claranet/puppet-newrelic/issues/11)
  * Linux Server: Exec now creates `/etc/newrelic/nrsysmond.cfg` before `nrsysmond-config` is run
  * Dependencies: Apt has been relaxed to `>= 2.3.0`

## 2.0.0 - 2017-08-23
  * Major rewrite of module
  * Please note that Windows support is _untested_

## 1.1.0 - 2017-08-11
  * Managing repo now optional

## 1.0.0 - 2017-08-08
  * Initial Forge Release
