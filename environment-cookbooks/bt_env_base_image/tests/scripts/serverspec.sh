#!/bin/bash

echo 'Installing ruby'
sudo yum install -y ruby
echo 'Installing bundler'
sudo gem install bundler --no-ri --no-rdoc
cd /tmp/tests
echo 'Installing gems'
bundle install --path=vendor
echo 'Running integration tests for ami'
bundle exec rake spec

