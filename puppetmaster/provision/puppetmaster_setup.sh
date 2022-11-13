#!/usr/bin/env bash

wget https://apt.puppet.com/puppet7-release-bullseye.deb

sudo dpkg -i puppet7-release-bullseye.deb

sudo apt-get update -y

sudo apt-get install puppetserver -y

#source /etc/profile.d/puppet-agent.sh
#echo $PATH



sudo sed -i 's/JAVA_ARGS="-Xms2g -Xmx2g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"/JAVA_ARGS="-Xms1g -Xmx1g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"/g' /etc/default/puppetserver


#sudo chown -R puppet /etc/puppetlabs/
#sudo chmod -R 0755 /etc/puppetlabs/

#sudo chown -R puppet /var/run/puppetlabs/
#sudo chown -R puppet /var/log/puppetlabs/
#sudo chmod -R 0755 /var/run/puppetlabs/


sudo systemctl start puppetserver
suso systemct enable puppetserver
sudo systemctl status puppetserver

sudo ufw allow from 192.168.56.1/24 to any proto tcp port 8140
sudo ufw status

##Configure puppet server
sudo /opt/puppetlabs/bin/puppet config set server puppetmaster.animals4life.local --section main
sudo /opt/puppetlabs/bin/puppet config set runinterval 1h --section main

sudo /opt/puppetlabs/bin/puppet config set environment production --section server
sudo /opt/puppetlabs/bin/puppet config set dns_alt_names puppetmaster,puppetmaster.animals4life.local --section server

sudo systemctl restart puppetserver



