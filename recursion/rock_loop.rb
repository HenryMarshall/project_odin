# make some random rocks
rocks = 30.times.map { rand (200 + 1) }
puts rocks.join(', ')
max_rock = 0

rocks.each do |rock|
  max_rock = rock if max_rock < rock
end

puts "heaviest rock is: #{max_rock}"