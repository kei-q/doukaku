require 'pry'
def solve(q)
  pos,ns = q.split(':')
  pos = pos.to_i
  ns = ns.chars.map{|_| _=='6' ? [6,9] : _.to_i}.flatten
  num6 = ns.count(6)
  ret = ns.permutation(4).select{|_| _[0] != 0}.select{|_|
    _.count{|e| e == 6 or e == 9} <= num6
  }
  ret= ret.uniq.sort
  ret.size < pos ? '-' : ret[pos-1].join
end

bindind.pry

DATA.readlines.each do |line|
  no,q,a = line.chop.split(/\s+/)
  ans = solve(q)
  print no + "\t" + ans
  puts ans == a ? ' o' : ' x'
end

__END__
0 13:01167  1109
1 1:1234  1234
2 2:1234  1243
3 7:1234  2134
4 24:1234 4321
5 25:1234 -
6 2:1116  1119
7 2:0116  1019
8 3:6666  6696
9 16:6666 9999
10  10:01267  1097
11  14:111167 1671
12  1:1111  1111
13  2:1111  -
14  1:666633  3366
15  72:666611 9999
16  73:666622 -
17  1:666600  6006
18  52:666600 9999
19  53:666600 -
20  25:06688  8086
21  93:02566  6502
22  11:06688  6809
23  169:01268 9801
24  174:01268 9821
25  66:012288 8201
