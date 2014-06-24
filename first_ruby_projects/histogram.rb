puts "Enter your string"
phrase = gets.chomp.split
results = Hash.new(0)
phrase.each do |word|
  results[word] += 1
end

results.sort_by { |key, value| value }.reverse.each do |key, value|
  puts "#{key}: #{value}"
end
