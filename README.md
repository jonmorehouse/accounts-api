# Accounts API
> Account creation and management for beam

## Overview




## Hacking

Set up environment
~~~ bash
$ export DOCKER_HOST=tcp://172.16.42.43:4243

# export host that docker containers listen on
$ export CONTAINER_HOST=$(echo $DOCKER_HOST | sed 's|^.*://||g' | sed 's|:.*$||g')

# export etcd connection information
$ export ETCD_HOST=$CONTAINER_HOST
$ export ETCD_PORT=4001

~~~

Set up docker-etcd and beam configuration for loading environment

~~~ bash

# clone projects
$ git clone jonmorehouse/docker-etcd
$ git clone beamio/config

# export paths to these projects, so accounts-api/bin/setup knows where to look
$ export DOCKER_ETCD=$(pwd)/docker-etcd
$ export BEAM_CONFIG=$(pwd)/config
~~~

Finally run the application so you can start hacking :)

~~~ bash

$ git clone beamio/accounts-api
$ cd accounts-api

# build environment using docker
$ ./bin/setup
$ npm install

# run application tests
$ cake tests
~~~



