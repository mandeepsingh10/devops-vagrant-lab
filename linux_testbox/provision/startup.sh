#!/usr/bin/env bash

password="msx@9797"
domain="animals4life.local"
domain_ip="192.168.56.2"

#update and upgrade os
sudo apt update -y
sudo apt upgrade -y

#install packages required
sudo apt install realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit -y


#install resolvconf
#sudo apt install resolvconf

# add domain entry in /etc/resolvconf/resolv.conf.d/base
#cd /etc/resolvconf/resolv.conf.d/
#cat <<EOT > base
#nameserver 192.168.56.2
#search localdomain
#EOT





