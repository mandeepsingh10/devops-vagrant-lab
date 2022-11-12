#!/usr/bin/env bash

wget https://apt.puppetlabs.com/puppet7-release-focal.deb

sudo dpkg -i puppet7-release-focal.deb

sudo apt-get update -y

sudo apt-get install puppetserver -y

sudo sed -i 's/JAVA_ARGS="-Xms2g -Xmx2g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"/JAVA_ARGS="-Xms1g -Xmx1g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"/g' /etc/default/puppetserver


sudo chown -R puppet /etc/puppetlabs/
sudo chmod -R 0755 /etc/puppetlabs/

sudo chown -R puppet /var/run/puppetlabs/
sudo chown -R puppet /var/log/puppetlabs/
sudo chmod -R 0755 /var/run/puppetlabs/



sudo systemctl start puppetserver
sudo systemctl enable puppetserver
sudo systemctl status puppetserver
