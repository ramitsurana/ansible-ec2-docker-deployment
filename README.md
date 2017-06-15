# Project1
Deploying wordpress blog using docker &amp; ansible on AWS

## Prerequisites

* Pythonv2.7
* Ansible
* Python Boto    
* Git

## Design

![ansible](https://cloud.githubusercontent.com/assets/8342133/26820071/2c1097a2-4abf-11e7-88d7-c303ee8e1473.png)

The design of the model is to deploy the ELK stack,Wordpress and Redis on top of the docker in an EC2 instance.This is done using docker compose and dockerfiles.The provisioning of the system is done using ansible.The file structure is as follows:

* Docker
  - app
    - wordpress
    - redis
    - docker-compose.yml
    - app-deploy.yml
  - elk
    - elasticsearch
    - kibana
    - logstash
    - docker-compose1.yml
    - elk-deploy.yml

* Deploy 
  - ec2-configure.yml

* Ansible
  - Info
    - aws-credentials.yml
    - specs.yml
  - provision.yml
  - hosts

## Steps:

### Creating EC2 

This can be done using the provision.yml file present in the ansible dir.It requires you to put your aws credentials [here](https://github.com/ramitsurana/project1/blob/master/ansible/info/aws-credentials.yml).The [specs.yml](https://github.com/ramitsurana/project1/blob/master/ansible/info/specs.yml) file stated the region,ami and instance type.THe command to run the ansible playbook is as follows:

````
$ sudo ansible-playbook provision.yml -i hosts -vv
````

### Configuring EC2

We can start configuring our EC2 instance by running some basic commands such as:

````
//Installing Docker
$ sudo apt-get remove docker docker-engine
$ sudo apt-get update
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
$ sudo apt-get install curl -y
$ sudo apt-get update
$ sudo apt-get install -y docker.io
$ sudo apt-get update
$ sudo usermod -aG docker ${USER}

//Installing docker compose
$ sudo su -
$ sudo apt-get  install python-pip -y
$ sudo pip install docker-compose
$ chmod +x /usr/local/bin/docker-compose

````

This can be done using the ec2-configure.yml file present in the repo.The command would be:

````
$sudo ansible-playbook ec2-configure.yml -vv --private-key  <path-to-keypair>
````



### Deploying ELK Stack using Docker Compose

It can be done using the ansible playbook.

````
$ sudo ansible-playbook elk-deploy.yml -vv --private-key <keypair>
````

The playbook consists of the below commands:

````
$ docker-compose -f docker-compose1.yml up -d
$ nc localhost 5000 < /var/log/auth.log

(https://gist.github.com/tsaarni/bb54e158fd453cb6d7cb)
````

### Deploying Wordpress and Redis Containers using Docker Compose

It can be done using the ansible playbook.


````
$ sudo ansible-playbook app-deploy.yml -vv --private-key <keypair>
````

The playbook consists of the following below commands:

````
$ docker-compose -f docker-compose.yml up -d
````

### Output

The output can be observed using the ip address of the ec2 instance.In order to fix the IP of the ec2 instance we can associate an elastic ip to the instance.The Public DNS would be like ec2-xxx-xxx-xxx.compute.amazonaws.com.

## License

MIT License

