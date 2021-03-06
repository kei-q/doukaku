require "pry"
require "awesome_print"

class Solver
  def initialize
    @field = [ [],[],[],[],[] ]
    @memo = [ [],[],[],[],[] ]
  end

  def check(c,x,y)
    length = @field.length - 1
    return nil if x < 0 || length < x || y < 0 || length < y
    [@field[y][x], x, y] if c < @field[y][x]
  end

  def count(len, n, x, y)
    if @memo[y][x] && len < @memo[y][x]
      @memo[y][x]
    else
      @memo[y][x] = len
      [check(n,x,y+1), check(n,x,y-1), check(n,x+1,y), check(n,x-1,y)].compact.map {|c,x,y|
        count(len+1,c,x,y)
      }.max || len
    end
  end

  def solve(input)
    @field = input.split("/").map(&:chars)

    max = 1
    @field.each_with_index {|line, y|
      line.each_with_index {|c,x|
        ret = count(1, c, x, y)
        max = ret if max < ret
      }
    }

    max.to_s
  end
end

def test(input, expected)
  actual = Solver.new.solve(input)
  if actual == expected
  else
    p "ng: #{input}, #{expected}, #{actual}"
  end
end

test( "01224/82925/69076/32298/21065", "6" )
test( "03478/12569/03478/12569/03478", "10" )
test( "09900/28127/87036/76545/87650", "10" )
test( "77777/77777/77777/77777/77777", "1" )
test( "00000/11111/22222/33333/44444", "5" )
test( "01234/12345/23456/34567/45678", "9" )
test( "10135/21245/43456/55567/77789", "8" )
test( "33333/33333/55555/55555/77777", "2" )
test( "01234/11234/22234/33334/44444", "5" )
test( "98765/88765/77765/66665/55555", "5" )
test( "01234/10325/23016/32107/45670", "8" )
test( "34343/43434/34343/43434/34343", "2" )
test( "14714/41177/71141/17414/47141", "3" )
test( "13891/31983/89138/98319/13891", "4" )
test( "01369/36901/90136/13690/69013", "5" )
test( "02468/24689/46898/68986/89864", "6" )
test( "86420/68642/46864/24686/02468", "5" )
test( "77777/75557/75357/75557/77777", "3" )
test( "53135/33133/11111/33133/53135", "3" )
test( "01356/23501/45024/61246/13461", "5" )
test( "46803/68025/91358/34792/78136", "4" )
test( "66788/56789/55799/43210/33211", "9" )
test( "40000/94321/96433/97644/98654", "9" )
test( "58950/01769/24524/24779/17069", "6" )
test( "97691/01883/98736/51934/81403", "4" )
test( "92049/27798/69377/45936/80277", "5" )
test( "97308/77113/08645/62578/44774", "5" )
test( "90207/17984/01982/31272/60926", "6" )
test( "62770/65146/06512/15407/89570", "4" )
test( "93914/46889/27554/58581/18703", "5" )
test( "42035/12430/60728/30842/90381", "5" )
test( "90347/53880/67954/95256/68777", "6" )
test( "05986/60473/01606/16425/46292", "5" )
test( "18053/90486/24320/04250/03853", "5" )
test( "36865/13263/67280/18600/12774", "5" )
test( "72456/72052/79971/14656/41151", "5" )
test( "94888/28649/05561/76571/97567", "5" )
test( "50214/94693/88718/78922/55359", "5" )
test( "76502/99325/17987/31737/93874", "7" )
test( "87142/14764/13014/00248/73105", "6" )
test( "24573/71679/48704/19786/91834", "7" )
test( "20347/61889/06074/61263/20519", "7" )
test( "74344/97459/97302/14439/35689", "6" )
test( "04794/52198/50294/09340/24160", "5" )
test( "41065/69344/64698/54167/43348", "7" )
test( "39947/15696/03482/19574/70235", "7" )
test( "92767/16790/84897/69765/75734", "7" )
test( "09654/79610/05070/23456/74687", "8" )
test( "73998/98799/98707/05633/23915", "8" )
test( "35661/17480/89723/64335/27217", "7" )
test( "02489/77571/84873/03879/84460", "7" )

binding.pry