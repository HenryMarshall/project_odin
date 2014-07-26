def append_times ary, n
  (n+1).times do |iter|
    ary << n - iter
  end
  # n.downto(0) { |i| ary << i }
  ary
end

def append_recursive ary, n
  if n < 0
    ary
  else
    append_recursive(ary << n, n - 1)
  end
end

def reverse_append ary, n
  return ary if n < 0
  reverse_append(ary, n - 1)
  ary << n
end


print reverse_append [], 4
puts