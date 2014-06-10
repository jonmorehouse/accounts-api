# Accounts API
> Account creation and management for beam

## Hacking

Set up etcd environment locally
~~~ bash

$ git clone beamio/docker-etcd

# configuration for this project lives in src/accounts_dev.toml
$ touch beamio/docker-etcd/src/accounts_dev.toml

# start container 
$ cd beamio/docker-etcd && ./bin/start accounts_dev.toml  

~~~

## Thoughts on Accounts

> Account object holds registration items and universal identifiers. Things such as phone numbers and social networks are not account-unique.

* usernames can not change, and are required for signup
* email addresses can change, but are required for signup so they are a part of the account


