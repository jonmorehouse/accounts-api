t = require 'test-bootstrap'

option "-p", "--filepath [filepath]", "filepath or directory"
task "test", "Run mocha specs for project or a particular file", (options) ->

  filepath = options.filepath ?= "test/spec"
  t.tasks.mocha filepath


