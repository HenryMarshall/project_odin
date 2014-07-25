require 'open-uri'
url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"

open("hamlet.txt", "w") do |f|
  f.write open(url).read
end

hamlet = open("hamlet.txt").readlines.each_with_index do |line, idx|
  puts line if idx % 42 == 0
end