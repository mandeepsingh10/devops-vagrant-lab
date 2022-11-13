#!/usr/bin/env bash

wget https://apt.puppet.com/puppet7-release-bullseye.deb

sudo dpkg -i puppet7-release-bullseye.deb

sudo apt-get update -y

sudo apt-get install puppet-agent -y
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

#sudo chown -R puppet /etc/puppetlabs/
#sudo chmod -R 0755 /etc/puppetlabs/

#sudo chown -R puppet /var/run/puppetlabs/
#sudo chown -R puppet /var/log/puppetlabs/
#sudo chmod -R 0755 /var/run/puppetlabs/

#cd /etc/puppetlabs/puppet
#cat <<EOT>> puppet.conf
#[main]
#certname = puppetclient
#server = puppetmaster
#EOT

sudo /opt/puppetlabs/bin/puppet set server puppetmaster.animals4life.local --section agent
sudo /opt/puppetlabs/bin/puppet config set ca_server puppetmaster.animals4life.local --section agent

sudo systemctl start puppet
sudo systemctl enable puppet
sudo systemctl status puppet
