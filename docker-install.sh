#!/bin/bash

echo "---------stage1: close firewalld ----------------"
sudo systemctl stop firewalld
sudo systemctl disable firewalld

echo "---------stage2: remove docker ----------------"
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

echo "---------stage3: install docker ----------------"
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --enable docker-ce-nightly
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo yum install docker-ce-18.09.1 docker-ce-cli-18.09.1 containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version

echo "---------stage3: install docker-compose ----------------"
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version