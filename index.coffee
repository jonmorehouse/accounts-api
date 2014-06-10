mc = require 'multi-config'
p = console.log

mc.env ["ETCD_HOST", "ETCD_PORT"], ->

  mc.etcd "accounts_service", (err) ->

    p err
    p mc


  


