#!/usr/bin/env bash

wget https://apt.puppet.com/puppet7-release-bullseye.deb

sudo dpkg -i puppet7-release-bullseye.deb

sudo apt-get update -y

sudo apt-get install puppetserver -y

#source /etc/profile.d/puppet-agent.sh
#echo $PATH



sudo sed -i 's/JAVA_ARGS="-Xms2g -Xmx2g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"/JAVA_ARGS="-Xms1g -Xmx1g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"/g' /etc/default/puppetserver


sudo systemctl start puppetserver.service
sudo systemctl enable puppetserver.service
sudo systemctl status puppetserver.service

##Configure puppet server
sudo /opt/puppetlabs/bin/puppet config set server puppetmaster.animals4life.local --section main
sudo /opt/puppetlabs/bin/puppet config set runinterval 1h --section main

sudo /opt/puppetlabs/bin/puppet config set environment production --section server
sudo /opt/puppetlabs/bin/puppet config set dns_alt_names puppet,puppetmaster,puppetmaster.animals4life.local --section server

sudo systemctl restart puppetserver



