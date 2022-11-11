#!/usr/bin/env bash
sudo apt install ca-certificates curl openssh-server tzdata perl -y
debconf-set-selections <<< "postfix postfix/mailname string a4l-git.animals4life.local"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
apt-get install --assume-yes postfix

cd /tmp
curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
sudo bash /tmp/script.deb.sh
sudo EXTERNAL_URL="http://a4l-git.animals4life" apt-get install gitlab-ce
sudo gitlab-ctl reconfigure
gitlab-ctl start


#add firewall rules
sudo ufw allow http
sudo ufw allow https
sudo ufw allow OpenSSH
