require 'pry'

def solve(input)
  dice = [1,6,2,5,3,4]
  dice[0]] + input.chars.map { |d|
    f,b,s,n,e,w = dice
    dice = case d
    when 'N' then [n,s, f,b, e,w]
    when 'S' then [s,n, b,f, e,w]
    when 'E' then [e,w, s,n, b,f]
    when 'W' then [w,e, s,n, f,b]
    else raise 'error'
    end
    dice[0]
  }
end

binding.pry