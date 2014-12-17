

assert = require 'assert'
{Solver} = require './18pre'

describe 'tests', ->
  for input, expected of Solver.tests
    do (input, expected) ->
      it "#{input} -> #{expected}", ->
        assert.equal((new Solver).solve(input), expected)
