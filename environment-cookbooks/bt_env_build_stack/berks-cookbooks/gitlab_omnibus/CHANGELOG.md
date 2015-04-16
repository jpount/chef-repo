# Changelog

0.2.1
---------
- Bug: Chef client 12.1.0 broke yum package install from source for
  CentOS. Change to RPM provider. See issue #6

0.2.0
---------
- Bug: Fix handling of various configuration values (nil, hash, array, etc)
- Feature: Install package from yum/apt repo instead of remote file download

0.1.0
---------
- Initial release
