#!/bin/bash
sleep 5s
sudo apt-get update
sudo apt-get upgrade
sleep 5s
sudo apt-get install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sleep 10s
sudo service docker start
