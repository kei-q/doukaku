# constants
# ------------------------------------------------------------------------------

FIELD = [
  'a b c d e',
  ' f g h i',
  'j k l m n',
  ' o p q r',
  's t u v w',
]

PATTERNS = {
  [[0,0],[1,1],[2,2],[3,1]] => 'B',
  [[0,0],[2,0],[4,0],[1,1]] => 'B',
  [[1,1],[2,0],[3,1],[4,2]] => 'B',
  [[0,0],[2,0],[1,1],[0,2]] => 'B',
  [[1,1],[3,1],[5,1],[4,0]] => 'B',
  [[2,0],[1,1],[0,2],[2,2]] => 'B',
  [[1,1],[2,2],[3,1],[4,0]] => 'D',
  [[0,0],[2,2],[1,1],[0,2]] => 'D',
  [[0,0],[2,0],[4,0],[3,1]] => 'D',
  [[2,0],[1,1],[0,2],[3,1]] => 'D',
  [[0,0],[2,0],[1,1],[2,2]] => 'D',
  [[2,0],[1,1],[3,1],[5,1]] => 'D',
  [[0,0],[2,0],[4,0],[6,0]] => 'I',
  [[0,0],[1,1],[2,2],[3,3]] => 'I',
  [[0,0],[2,0],[4,0],[6,0]] => 'I',
  [[4,0],[3,1],[2,2],[1,3]] => 'I',
}.freeze

# main
# ------------------------------------------------------------------------------

def find_c(c)
  (0 .. FIELD.length).each do |y|
    (0 .. FIELD[0].length).each do |x|
      return [x,y] if FIELD[y][x] == c
    end
  end
end

def find_pos(input)
  input.chars.map { |c| find_c(c) }
end

def move(pos)
  minx = pos.map {|xy| xy[0] }.min
  miny = pos.map {|xy| xy[1] }.min
  ret = pos.map {|xy| [xy[0]-minx,xy[1]-miny] }.sort
  if ret.include?([0,1]) || ret.include?([0,3])
    ret = ret.map {|xy| [xy[0]+1,xy[1]]}
  end
  ret
end

def check(pos)
  PATTERNS.each do |pattern, id|
    return id if pattern.sort == pos
  end
  '-'
end

# main
# ------------------------------------------------------------------------------

def solve(input)
  pos = find_pos input
  check (move pos)
end

def parse(input)
  input
end

sample = 'himr'
pos = find_pos sample
p pos
p move pos

# test
# ------------------------------------------------------------------------------

$index = 0
def test(input, expected)
  actual = (solve(parse input)).to_s
  ret = actual.to_s == expected
  unless ret
    p [$index, actual, expected, ret, input]
  end
  $index += 1
end

test( "glmq", "B" );
test( "fhoq", "-" );
test( "lmpr", "-" );
test( "glmp", "-" );
test( "dhkl", "-" );
test( "glpq", "D" );
test( "hlmq", "-" );
test( "eimq", "I" );
test( "cglp", "-" );
test( "chlq", "-" );
test( "glqr", "-" );
test( "cdef", "-" );
test( "hijk", "-" );
test( "kpqu", "B" );
test( "hklm", "B" );
test( "mqrw", "B" );
test( "nrvw", "B" );
test( "abfj", "B" );
test( "abcf", "B" );
test( "mrvw", "D" );
test( "ptuv", "D" );
test( "lmnr", "D" );
test( "hklp", "D" );
test( "himr", "D" );
test( "dhil", "D" );
test( "hlpt", "I" );
test( "stuv", "I" );
test( "bglq", "I" );
test( "glmn", "-" );
test( "fghm", "-" );
test( "cdgk", "-" );
test( "lpst", "-" );
test( "imrw", "-" );
test( "dinr", "-" );
test( "cdin", "-" );
test( "eghi", "-" );
test( "cdeg", "-" );
test( "bgko", "-" );
test( "eimr", "-" );
test( "jotu", "-" );
test( "kotu", "-" );
test( "lqtu", "-" );
test( "cdim", "-" );
test( "klot", "-" );
test( "kloq", "-" );
test( "kmpq", "-" );
test( "qrvw", "-" );
test( "mnqr", "-" );
test( "kopt", "-" );
test( "mnpq", "-" );
test( "bfko", "-" );
test( "chin", "-" );
test( "hmnq", "-" );
test( "nqrw", "-" );
test( "bchi", "-" );
test( "inrw", "-" );
test( "cfgj", "-" );
test( "jnpv", "-" );
test( "flmp", "-" );
test( "adpw", "-" );
test( "eilr", "-" );
test( "bejv", "-" );
test( "enot", "-" );
test( "fghq", "-" );
test( "cjms", "-" );
test( "elov", "-" );
test( "chlm", "D" );
test( "acop", "-" );
test( "finr", "-" );
test( "qstu", "-" );
test( "abdq", "-" );
test( "jkln", "-" );
test( "fjkn", "-" );
test( "ijmn", "-" );
test( "flqr", "-" );
