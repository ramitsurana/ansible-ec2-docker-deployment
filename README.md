# Project1
Deploying wordpress blog using docker &amp; ansible on AWS

## Prerequisites

* Pythonv2.7
* Ansible
* Python Boto    
* Git

## Design

![ansible](https://cloud.githubusercontent.com/assets/8342133/26820071/2c1097a2-4abf-11e7-88d7-c303ee8e1473.png)

## Steps:
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
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
$ sudo apt-get update
$ sudo apt-get install docker-ce
$ sudo usermod -aG docker ubuntu

(Steps taken from - https://docs.docker.com/engine/installation/linux/ubuntu/#install-using-the-repository)

//Installing docker compose
$ sudo su -
$ curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
$ chmod +x /usr/local/bin/docker-compose

````

This can be done using the ec2-configure.yml file present in the repo.The command would be:

````
$ ansible-playbook ec2-configure.yml -i hosts --private-key  <path-to-keypair>
````



### Deploying ELK Stack using Docker Compose

It can be done using the ansible playbook.

$ ansible-playbook ./elk-deploy.yml --private-key <keypair>

The playbook consists of the below commands:

````
$ docker-compose -f docker-compose1.yml up -d
$ nc localhost 5000 < /var/log/auth.log

(https://gist.github.com/tsaarni/bb54e158fd453cb6d7cb)
````



### Deploying Wordpress and Redis Containers using Docker Compose

It can be done using the ansible playbook.

$ ansible-playbook ./app-deploy.yml --private-key <keypair>

The playbook consists of the following below commands:

````
$ docker-compose -f docker-compose.yml up -d
````

## License

MIT License

