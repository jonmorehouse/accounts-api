# Accounts API
> Account creation and management for beam

## Hacking

~~~ bash
# assume that configuration is managed in docker etcd-seed
$ git clone beamio/docker-etcd

# configuration for this project lives in src/accounts_dev.toml
$ touch beamio/docker-etcd/src/accounts_dev.toml

# start container 
$ cd beamio/docker-etcd && ./bin/start accounts_dev.toml  

~~~






