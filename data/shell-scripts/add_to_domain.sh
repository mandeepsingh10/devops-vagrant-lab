#!/usr/bin/env bash

password="msx@9797"
domain="msx.local"
domain_ip="192.168.56.2"

#join the realm

sudo echo $password | realm join -U administrator $domain

#update /usr/share/pam-configs/mkhomedir

cd /usr/share/pam-configs

cat <<EOT> mkhomedir
Name: Create home directory on login
Default: yes
Priority: 900
Session-Type: Additional
Session:
	optional			pam_mkhomedir.so
EOT

#enable homedirectory creation on login
pam-auth-update --enable mkhomedir
sudo systemctl restart sssd.service

#update sssd config
cd /etc/sssd
cat <<EOT> sssd.conf
[sssd]
domains = msx.local
config_file_version = 2
services = nss, pam

[domain/msx.local]
ad_domain = msx.local
krb5_realm = MSX.LOCAL
realmd_tags = manages-system joined-with-adcli
cache_credentials = True
id_provider = ad
krb5_store_password_if_offline = True
default_shell = /bin/bash
ldap_id_mapping = True
use_fully_qualified_names = False
fallback_homedir = /home/%u
access_provider = simple
EOT

sudo systemctl restart sssd.service

#allow ad groups to login to the server
sudo realm permit -g linux_users@msx.local
sudo realm permit -g linux_admins@msx.local
sudo systemctl restart sssd.service

#update password login
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd.service

## Allow sudo access to linux-admins

cd /etc/sudoers.d/

cat <<EOT> linux_admins
%linux_admins ALL=(ALL) NOPASSWD:ALL
EOT

#Allow users to run puppet command with sudo. ex - sudo puppet agent -tvvv
sudo sed -e '/secure_path/s/^/#/g' -i /etc/sudoers

#System has been provisioned
