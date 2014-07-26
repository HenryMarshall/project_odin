def sum_upto number
  if number == 1
    1
  else
    number + sum_upto(number-1)
  end
end

puts sum_upto 99