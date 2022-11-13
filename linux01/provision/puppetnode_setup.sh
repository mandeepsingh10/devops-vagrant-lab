#!/usr/bin/env bash

wget https://apt.puppet.com/puppet7-release-bullseye.deb

sudo dpkg -i puppet7-release-bullseye.deb

sudo apt-get update -y

sudo apt-get install puppet-agent -y
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

#add puppetmaster entry in /etc/hosts file
cd /etc
cat <<EOT>> hosts
192.168.56.7	puppetmaster.animals4life.local	puppet
EOT

sudo /opt/puppetlabs/bin/puppet config set server puppetmaster.animals4life.local --section agent
sudo /opt/puppetlabs/bin/puppet config set ca_server puppetmaster.animals4life.local --section agent

sudo systemctl start puppet
sudo systemctl enable puppet
sudo systemctl status puppet
