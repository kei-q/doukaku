def calc(input)
  input.combination(2).map {|a,b|
    c,d = a.divmod(10).zip(b.divmod(10)).map{|x,y|x-y}
    c*c + d*d
  }.sort
end

result = [
  ['L',[0,1,2,10]],
  ['I',[0,1,2,3]],
  ['O',[0,1,10,11]],
  ['T',[0,1,2,11]],
  ['S',[0,1,11,12]],
].each_with_object({}) {|(k,v),hash| hash[calc(v)] = k }

File.readlines('input.txt').each { |input|
  expected, *list = input.split(' ')
  p("actual: #{result[calc(list.map(&:to_i))] or '-'} expected: #{expected}")
}
