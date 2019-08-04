#!/bin/bash

# UNINSTALL OLDER DOCKER
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# SET UP THE REPOSITORY

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo


# INDTSLL DOCKER
yum install docker-ce docker-ce-cli containerd.io

# SET UP CONTAINER SPEED
if test -e /usr/bin/docker
then
	curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://ef017c13.m.daocloud.io
else
	echo 'Installation failed'
fi

