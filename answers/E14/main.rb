
# [[Int]]
def parse(input)
  lines = input.split(',')
  lines.map {|line| line.chars.map(&:to_i)}
end


PATTERNS = [
  { [0,0] => 0, [0,1] => 1, [0,2] => 0, [1,1] => 2, [2,1] => 1, [3,1] => 2 },
  { [0,0] => 0, [0,1] => 1, [1,2] => 0, [1,1] => 2, [2,1] => 1, [3,1] => 2 },
  { [0,0] => 0, [0,1] => 1, [2,2] => 0, [1,1] => 2, [2,1] => 1, [3,1] => 2 },
  { [0,0] => 0, [0,1] => 1, [3,2] => 0, [1,1] => 2, [2,1] => 1, [3,1] => 2 },
  { [1,0] => 0, [0,1] => 1, [1,2] => 0, [1,1] => 2, [2,1] => 1, [3,1] => 2 },
  { [1,0] => 0, [0,1] => 1, [2,2] => 0, [1,1] => 2, [2,1] => 1, [3,1] => 2 },
  { [0,0] => 0, [2,1] => 0, [1,0] => 1, [2,2] => 1, [1,1] => 2, [3,1] => 2 },
  { [0,0] => 0, [2,1] => 0, [1,0] => 1, [1,2] => 1, [1,1] => 2, [3,1] => 2 },
  { [0,0] => 0, [2,1] => 0, [1,0] => 1, [2,2] => 1, [1,1] => 2, [3,2] => 2 },
  { [0,0] => 0, [2,1] => 0, [1,0] => 1, [3,2] => 1, [1,1] => 2, [3,1] => 2 },
  { [0,0] => 0, [2,0] => 0, [1,0] => 1, [3,1] => 1, [2,1] => 2, [4,1] => 2 },
]

def check(field)
  (0 .. field.length).each do |y|
    (0 .. field[0].length).each do |x|
      PATTERNS.each do |pattern|
        ns = []
        tmp = [0,0,0]
        pattern.each do |k,v|
          dx,dy = k
          line = field[y+dy]
          break unless line
          n = line[x+dx].to_i
          tmp[v] += n
          ns << n
        end
        return true if tmp == [7,7,7] && ns.uniq.length == 6
      end
    end
  end
  false
end

def solve(field)
  orig = field
  2.times do
    ret = check(field)
    return true if ret
    field = field.transpose
  end
  field = orig.reverse
  2.times do
    ret = check(field)
    return true if ret
    field = field.transpose
  end
  field = orig.map(&:reverse)
  2.times do
    ret = check(field)
    return true if ret
    field = field.transpose
  end
  field = orig.reverse.map(&:reverse)
  2.times do
    ret = check(field)
    return true if ret
    field = field.transpose
  end
  false
end

sample = '5262,4631,2644'
input = parse sample
puts solve input

$index = 0
def test(input, expected)
  actual = (solve(parse input)).to_s
  ret = actual.to_s == expected
  unless ret
    p [$index, actual, expected, ret]
  end
  $index += 1
end

test("44165,44516", "false");
test("26265,31436", "true");
test("46345,54215", "true");
test("62143,11152", "false");
test("4242,4314,1562", "false");
test("5612,3656,4523", "false");
test("5514,1311,5252", "false");
test("5262,4631,2644", "true");
test("6626,3324,2644", "false");
test("4645,6314,2564", "true");
test("54,65,23,21,14", "true");
test("5325,3641,1335", "true");
test("4163,2156,2553", "true");
test("3126,6543,4352", "false");
test("4464,5423,5216", "true");
test("3564,3634,5631", "false");
test("4363,3454,2126", "true");
test("25,25,33,12,52", "false");
test("1551,4542,3624", "true");
test("6623,4126,6331", "false");
test("2432,6215,1623", "true");
test("1151,6555,3616", "false");
test("2466,1242,4444", "false");
test("5646,1463,4244", "true");
test("1255,6413,4534", "true");
test("1325,2312,2425", "false");
test("2544,6413,4656", "true");
test("1656,4131,3235", "true");
test("6332,3631,4113", "false");
test("4525,2151,2336", "true");
test("1645,2356,4314", "true");
test("3334,6215,1553", "true");
test("2622,5251,5165", "false");
test("1111,5613,3451", "false");
test("6146,4512,6353", "true");
test("2455,3312,6461", "false");
test("1221,1325,1422", "false");
test("1562,2236,5212", "false");
test("6622,3324,5155", "true");
test("2352,4631,1236", "true");
test("4645,2252,6554", "false");
test("3542,6515,1231", "true");
test("12,61,56,45,23", "false");
test("4643,6522,3625", "false");
test("1151,1642,4512", "false");
test("5423,5146,2212", "false");
test("6224,3412,5653", "true");
test("3122,5423,6231", "true");
test("5421,2351,6513", "false");
test("5652,3542,3313", "true");
test("5524,3335,1146", "false");
test("5311,4126,6425", "true");
test("15,43,62,42,14", "true");
test("3631,3542,3265", "true");
test("1232,5364,6135", "true");
test("2441,4644,5433", "false");
test("2213,5621,3412", "true");
test("6644,1264,1235", "true");
test("5613,1423,6315", "true");
test("6552,1546,2141", "false");
test("5623,1461,5645", "true");
test("1442,1436,6362", "false");
test("3443,5145,4546", "false");
test("1244,1313,2316", "false");
test("2152,1463,2114", "true");
test("1211,6234,5561", "false");
test("4152,1252,3142", "false");
test("6645,1231,6122", "false");
test("353,241,121,536", "true");
test("224,444,651,234", "true");
test("643,214,244,343", "false");
test("624,542,214,333", "true");
test("441,426,536,656", "true");
test("564,642,513,364", "true");
test("422,136,414,416", "false");
test("463,356,113,662", "true");
test("464,515,435,462", "true");
test("531,145,364,525", "false");
test("623,564,153,633", "false");
test("335,462,531,424", "false");
test("131,111,535,436", "false");
test("435,414,423,365", "true");
test("144,512,332,346", "true");
test("342,246,342,634", "false");
test("246,566,431,415", "true");
test("444,554,234,621", "true");
test("313,624,165,652", "true");
test("563,262,545,315", "true");
test("213,264,154,264", "false");
test("364,434,246,113", "false");
test("411,656,325,225", "false");
test("624,234,115,443", "true");
test("252,214,635,154", "false");
test("146,213,525,164", "false");
test("456,423,112,352", "true");
test("253,156,111,355", "false");
test("252,161,562,365", "false");
test("136,553,544,524", "true");
test("414,351,161,525", "true");
test("261,442,111,531", "true");
test("323,664,454,133", "true");
test("213,415,225,165", "false");
test("363,162,165,533", "false");
test("346,441,315,241", "false");
test("121,312,155,164", "true");
test("123,311,452,365", "true");
test("361,145,212,431", "true");
test("451,264,412,513", "false");
test("311,456,263,226", "true");
test("343,442,624,635", "false");
test("534,644,234,251", "false");
test("515,346,462,435", "true");
test("445,126,165,636", "false");
test("343,355,126,353", "false");
test("623,533,256,144", "true");
test("125,341,566,416", "false");
test("354,434,621,411", "true");
test("356,435,253,114", "false");
test("141,265,533,514", "true");
test("613,426,142,535", "true");
test("366,322,413,325", "true");
test("331,542,343,545", "false");
test("261,512,563,123", "false");
test("242,132,656,164", "true");
test("133,545,441,665", "false");
test("111,151,621,545", "false");
test("132,154,234,653", "false");
test("114,455,635,511", "false");
test("14366,64254,66664,42611,41245", "false");
test("41114,53116,13122,66613,35111", "false");
test("22146,34244,16154,62531,51426", "true");
test("464316,136563,136326,535655,641161,252655", "true");
test("166255,615452,261224,533566,323335,556213", "false");
test("126665,245653,343553,254661,365415,361154", "false");
test("1512663,1525531,5456426,6336325,4324465,6512242,4112466", "true");
test("2236563,6644542,4425515,6641142,4214543,1156426,3225413", "false");
test("5545354,6566343,3525411,5356165,4625265,1535435,5522665", "false");
test("16161,61616,16161", "false");
test("2431,6354,2341", "false");
