#!/bin/bash

FOLDER_PATH='$HOME/projects/personal/ansible-ec2-docker-deployment/'
EC2_PEM_FILE='$HOME/Downloads/ramit-rean.pem'

VPC_PROVISION_FILE='vpc-provision.yml'
EC2_FILE='provision.yml'
EC2_CONFIG_FILE='ec2-configure.yml'
ELK_CONFIG_FILE='elk-deploy.yml'
APP_CONFIG_FILE='app-deploy.yml'

AWS_REGION='us-east-1'
TAG_NAME='aws-docker-ansible'

function DeployPlaybook {
	sudo ansible-playbook $1 -i hosts -vv
}

function ConfigurePlaybook {
        sudo ansible-playbook $1 -vv --private-key $2
}

function ListID {
        aws ec2 $1 --filter Name=tag:Name,Values=$TAG_NAME --region=$AWS_REGION
}

## Create an VPC
cd $FOLDER_PATH/ansible/
DeployPlaybook $VPC_PROVISION_FILE

## List ID and Replace info
ListID describe-vpcs

## Create an EC2
cd $FOLDER_PATH/ansible/
DeployPlaybook $EC2_FILE

## Configuring EC2 Server
cd $FOLDER_PATH/deploy/
ConfigurePlaybook $EC2_CONFIG_FILE $EC2_PEM_FILE

## Configuring ELK 
cd $FOLDER_PATH/docker/elk/
ConfigurePlaybook $ELK_CONFIG_FILE $EC2_PEM_FILE

## Configuring Wordpress
cd $FOLDER_PATH/docker/app/
ConfigurePlaybook $APP_CONFIG_FILE $EC2_PEM_FILE

