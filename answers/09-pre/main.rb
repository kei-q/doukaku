require 'pry'

def sixes(n)
  tmp = '6' * n
  result = []
  n.times { |i|
    result << tmp.dup
    tmp[i] = '9'
  }
  result << tmp
  result
end

def solve(input)
  nth, cards = input.split(':')
  result = sixes(cards.count('6')).flat_map {|six|
    pats = (cards.delete('6') + six).chars.permutation(4).to_a
    pats = pats.reject {|s| s[0] == '0'}
  }.sort.uniq[nth.to_i-1]
  result ? result.join : "-"
end

binding.pry