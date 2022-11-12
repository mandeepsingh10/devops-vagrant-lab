#!/usr/bin/env bash

server_name="a4l-git"
password="msx@9797"
domain="animals4life.local"
domain_ip="192.168.56.2"

#update and upgrade os
sudo apt update -y
sudo apt upgrade -y

#install packages required
sudo apt install realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit  resolvconf ncdu tree -y

##change hostname

hostnamectl set-hostname $server_name.$domain

#update initial nameserver config in resolv.conf
cd /etc
cat <<EOT> resolv.conf
search animals4life.local
nameserver 192.168.56.2
options edns0
EOT

#install resolvconf
#sudo apt install resolvconf

# add domain entry in /etc/resolvconf/resolv.conf.d/base
cd /etc/resolvconf/resolv.conf.d/
cat <<EOT > base
# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
# 127.0.0.53 is the systemd-resolved stub resolver.
# run "systemd-resolve --status" to see details about the actual nameservers.

search animals4life.local
nameserver 192.168.56.2
EOT

#add domain entry in /etc/resolvconf/resolv.conf.d/head
cd /etc/resolvconf/resolv.conf.d/
cat <<EOT > head
# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
# 127.0.0.53 is the systemd-resolved stub resolver.
# run "systemd-resolve --status" to see details about the actual nameservers.

search animals4life.local
nameserver 192.168.56.2
EOT

# apply changes to /etc/resolv.conf
sudo resolvconf -u
