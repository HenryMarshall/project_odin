def rock_judger rocks
  if rocks.length <= 2
    a = rocks[0]
    b = rocks[-1]
  else
    a = rock_judger rocks.slice!(0, rocks.length/2)
    b = rock_judger rocks
  end

  return a > b ? a : b
end

rocks = 30.times.map { rand(200) + 1 }
puts rocks.join(', ')
puts "Heaviest rocks is: #{rock_judger rocks}"