# test command:
# mocha 18pre-test.coffee --compilers coffee:coffee-script/register
# mocha 18pre-test.coffee --compilers coffee:coffee-script/register --reporter min --require 18pre.coffee --watch


_ = require 'underscore-contrib'
_.str = require 'underscore.string'
_.mixin(_.str.exports())

consume = (memo) ->
  for x in _.zip(memo,[2,7,3,5,2])
    [[h..., t], n] = x
    _.cat(h, _.max([0,t - n]))

produce = (memo, count) ->
  target_no = search(memo)
  target = memo[target_no]
  target[0] += count
  memo[target_no] = target
  memo

bad = (memo) ->
  target_no = search(memo)
  memo[target_no] = _.cat(1, memo[target_no])
  memo

search = (memo) ->
  index = 0
  [val, memo_...] = count memo
  for x,i in memo_
    [index, val] = [i+1, x] if x < val
  index

count = (memo) -> _.map(memo, sum)

sum = (ns) ->
  _.foldl ns, ((memo, n) -> memo+n), 0

class Solver
  solve: (input) ->
    result = _.foldl _.chars(input), @act, [[9],[0],[0],[0],[0]]
    _.join(',', String(n) for n in count(result))

  act: (memo, c) ->
    switch c
      when 'x' then bad(memo)
      when '.' then consume(memo)
      else produce(memo, parseInt(c))

  @tests:
    "42873x.3.": "0,4,2,0,0"
    "1": "1,0,0,0,0"
    ".": "0,0,0,0,0"
    "x": "1,0,0,0,0"
    "31.": "1,0,0,0,0"
    "3x.": "1,1,0,0,0"
    "99569x": "9,9,6,6,9"
    "99569x33": "9,9,9,9,9"
    "99569x33.": "7,2,6,4,7"
    "99569x33..": "5,0,4,0,5"
    "12345x3333.": "4,0,3,2,3"
    "54321x3333.": "3,0,3,0,4"
    "51423x3333.": "3,4,4,0,4"
    "12x34x.": "1,0,1,0,2"
    "987x654x.32": "7,6,4,10,5"
    "99999999999x99999999.......9.": "20,10,12,5,20"
    "997": "9,9,7,0,0"
    ".3.9": "1,9,0,0,0"
    "832.6": "6,6,0,0,0"
    ".5.568": "3,5,6,8,0"
    "475..48": "4,8,0,0,0"
    "7.2..469": "1,4,6,9,0"
    "574x315.3": "3,3,1,7,1"
    "5.2893.x98": "10,9,5,4,1"
    "279.6xxx..4": "2,1,4,1,1"
    "1.1.39..93.x": "7,1,0,0,0"
    "7677749325927": "16,12,17,18,12"
    "x6235.87.56.9.": "7,2,0,0,0"
    "4.1168.6.197.6.": "0,0,3,0,0"
    "2.8.547.25..19.6": "6,2,0,0,0"
    ".5.3x82x32.1829..": "5,0,5,0,7"
    "x.1816..36.24.429.": "1,0,0,0,7"
    "79.2.6.81x..26x31.1": "1,0,2,1,1"
    "574296x6538984..5974": "14,13,10,15,14"
    "99.6244.4376636..72.6": "5,6,0,0,3"
    "1659.486x5637168278123": "17,16,16,18,17"
    ".5.17797.x626x5x9457.3.": "14,0,3,5,8"
    "..58624.85623..4.7..23.x": "1,1,0,0,0"
    "716.463.9.x.8..4.15.738x4": "7,3,5,8,1"
    "22xx.191.96469472.7232377.": "10,11,18,12,9"
    "24..4...343......4.41.6...2": "2,0,0,0,0"
    "32732.474x153.866..4x29.2573": "7,5,7,8,5"
    "786.1267x9937.17.15448.1x33.4": "4,4,8,4,10"
    "671714849.149.686852.178.895x3": "13,16,13,10,12"
    "86x.47.517..29621.61x937..xx935": "7,11,8,8,10"
    ".2233.78x.94.x59511.5.86x3.x714.": "4,6,10,8,8"
    ".793...218.687x415x13.1...x58576x": "8,11,8,6,9"
    "6.6x37.3x51x932.72x4x33.9363.x7761": "15,13,15,12,15"
    "6..4.x187..681.2x.2.713276.669x.252": "6,7,8,6,5"
    ".6.xx64..5146x897231.x.21265392x9775": "19,17,19,20,17"
    "334.85413.263314.x.6293921x3.6357647x": "14,14,12,16,10"
    "4.1..9..513.266..5999769852.2.38x79.x7": "12,10,13,6,10"

module.exports =
  Solver: Solver
  r: ->
    path = require "path"
    delete require.cache[path.resolve("./18pre.coffee")]
    {Solver, reload} = require "./18pre"
    new Solver
