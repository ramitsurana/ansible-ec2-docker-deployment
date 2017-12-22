# Installation

## Docker-Compose

1. sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

2. sudo chmod +x /usr/local/bin/docker-compose

[Ref](https://docs.docker.com/compose/install/)

## Docker

1. sudo apt-get remove docker docker-engine docker.io

2. sudo apt-get update

3. sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    
4. curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

5. sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

6. sudo apt-get update

7. sudo apt-get install docker-ce

