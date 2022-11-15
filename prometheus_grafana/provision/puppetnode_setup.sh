#!/usr/bin/env bash

wget https://apt.puppet.com/puppet7-release-bullseye.deb

sudo dpkg -i puppet7-release-bullseye.deb

sudo apt-get update -y

sudo apt-get install puppet-agent -y


sudo /opt/puppetlabs/bin/puppet config set server puppetmaster.msx.local --section main
sudo /opt/puppetlabs/bin/puppet config set ca_server puppetmaster.msx.local --section main
sudo /opt/puppetlabs/bin/puppet config set runinterval 30m --section main
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
sudo systemctl start puppet
sudo systemctl enable puppet
sudo systemctl status puppet

