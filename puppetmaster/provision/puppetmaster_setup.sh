#!/usr/bin/env bash

wget https://apt.puppetlabs.com/puppet7-release-focal.deb

sudo dpkg -i puppet6-release-focal.deb

sudo apt-get update -y

sudo apt-get install puppetserver -y


