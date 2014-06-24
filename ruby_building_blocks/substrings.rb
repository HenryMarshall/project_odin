def substrings str, dictionary
  str.downcase!
  results = Hash.new(0)

  dictionary.each do |substring|
    searching_string = true
    idx = 0
    # should have used scan
    while searching_string
      idx = str.index(substring, idx)
      if idx.nil?
        searching_string = false
      else
        results[substring] += 1
        # increment idx for next loop to skip existing match
        idx += 1
      end
    end
  end
  results
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("Howdy partner, sit down! How's it going?", dictionary)