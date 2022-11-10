#!/usr/bin/env bash

sudo apt update -y
sudo apt install openjdk-8-jdk -y
sudo apt install openjdk-11-jdk -y

#importing the GPG key for jenkins repo
sudo curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

#Add the Jenkins software repository to the source list and provide the authentication key:
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

#Install Jenkins and enable on startup
sudo apt update
sudo apt install jenkins -y
sudo systemctl enable --now jenkins

#Modify Firewall to Allow Jenkins
sudo ufw allow 8080
sudo ufw enable

#Display the initial admin password for jenkins 
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# System has been provisioned
