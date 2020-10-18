#!/bin/bash -xe
set -e
#https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-ubuntu.html

REGION=us-east-1
AUTOUPDATE=false
apt-get -y update
# Installing Code Deploy Agent
apt-get -y install jq awscli ruby2.0 wget || apt-get -y install jq awscli ruby wget

cd /tmp/
wget https://aws-codedeploy-${REGION}.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto

service codedeploy-agent start
service codedeploy-agent status

# Install the Amazon CloudWatch Logs Agent
cd /home/ubuntu
sudo apt -y install build-essential libssl-dev libffi-dev libyaml-dev python-dev
sudo apt-get install python-pip -y

wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i -E ./amazon-cloudwatch-agent.deb

curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
chmod +x ./awslogs-agent-setup.py

#configuration part
wget https://s3.amazonaws.com/aws-codedeploy-us-east-1/cloudwatch/codedeploy_logs.conf
mkdir -p /var/awslogs/etc/
cp codedeploy_logs.conf /var/awslogs/etc/

./awslogs-agent-setup.py -n -r us-east-1 -c /var/awslogs/etc/codedeploy_logs.conf
sudo service awslogs start
sudo service awslogs status
# tail /var/log/awslogs.log
# Access Log on: https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#logs: