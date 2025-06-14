#!/bin/bash

echo "Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

echo "Installing Java (Jenkins dependency)..."
sudo apt install openjdk-17-jdk -y

echo "Adding Jenkins repository key..."
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "Adding Jenkins repository to sources list..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package index..."
sudo apt update -y

echo "Installing Jenkins..."
sudo apt install jenkins -y

echo "Enabling and starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Allowing port 8080 through UFW firewall..."
sudo ufw allow 8080
sudo ufw --force enable

echo "Installation complete!"
echo "Jenkins should now be running at: http://<your_server_ip>:8080"
echo "Use the following command to get the initial admin password:"
echo "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
