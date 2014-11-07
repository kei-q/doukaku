_ = require 'underscore'

railmap = [ ['1', "ag"] , ['2', "dh"] , ['3', "bf"] , ['a', "b"] , ['b', "c5"] , ['c', "46"] , ['d', "ce"] , ['e', "5"] , ['f', "g"] , ['g', "ceh"] , ['h', "4i"] , ['i', "6"] ]

solve = (input) ->
  railmap_ = _.reject railmap, (rail) ->
    _.contains input, rail[0]
  ret = _.flatten [
    makePair('1', cleaning(findDeadEnd railmap_, '1')),
    makePair('2', cleaning(findDeadEnd railmap_, '2')),
    makePair('3', cleaning(findDeadEnd railmap_, '3')),
  ], true
  if ret.length == 0
    "-"
  else
    ret.toString()

makePair = (c, deadends) ->
  _.map deadends, (d) ->
    "#{c}#{d}"

cleaning = (deadends) ->
  ret = []
  ret += '4' if _.contains deadends, '4'
  ret += '5' if _.contains deadends, '5'
  ret += '6' if _.contains deadends, '6'
  ret

findDeadEnd = (rmap, start) ->
  next = _.find rmap, (rail) ->
    rail[0] == start
  if next
    ret = _.map next[1], (start_) ->
      findDeadEnd rmap, start_
    _.flatten ret
  else
    [start]

test = (input, expected) ->
  actual = solve input
  if actual == expected
    console.log "ok: #{input}"
  else
    console.log "NG!!!: #{input}: #{expected}: #{actual}"

tests = ->
  test("befi", "14,16,24,26" )
  test("abc", "14,15,16,24,25,26,34,35,36" )
  test("de", "14,15,16,24,26,34,35,36" )
  test("fghi", "14,15,16,24,25,26,34,35,36" )
  test("abcdefghi", "-" )
  test("ag", "24,25,26,34,35,36" )
  test("dh", "14,15,16,34,35,36" )
  test("bf", "14,15,16,24,25,26" )
  test("ch", "15,25,35" )
  test("be", "14,16,24,26,34,36" )
  test("ci", "14,15,24,25,34,35" )
  test("cgi", "15,24,25,35" )
  test("acgi", "24,25,35" )
  test("cdefghi", "15,35" )
  test("acdefghi", "35" )
  test("cdegi", "15,24,35" )
  test("bcdegi", "24" )
  test("afh", "14,15,16,24,25,26,34,35,36" )
  test("abfh", "14,15,16,24,25,26" )
  test("dfh", "14,15,16,34,35,36" )
  test("cdfh", "15,35" )
  test("deh", "14,15,16,34,35,36" )
  test("cdeh", "15,35" )
  test("abefgh", "24,26" )
  test("abdefgh", "-" )
  test("acfghi", "25,35" )
  test("acdfghi", "35" )
  test("cegi", "15,24,35" )
  test("abcfhi", "15,25" )
  test("abcefhi", "-" )
  test("abdi", "14,15,16,24,34,35,36" )
  test("abdfi", "14,15,16,24" )
  test("bdi", "14,15,16,24,34,35,36" )
  test("bdfi", "14,15,16,24" )
  test("adfh", "14,15,16,34,35,36" )
  test("adfgh", "34,35,36" )
  test("acdfhi", "15,35" )
  test("bcdfgi", "24" )
  test("bcdfghi", "-" )
  test("defi", "14,15,16,24,34,35,36" )
  test("defhi", "14,15,16,34,35,36" )
  test("cdefg", "15,24,26,35" )
  test("cdefgi", "15,24,35" )
  test("bdefg", "24,26" )
  test("bdefgi", "24" )

tests()
