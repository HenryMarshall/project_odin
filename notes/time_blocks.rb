# pass a block into a method
def profile description, &block
  start_time = Time.now
  block.call
  duration = Time.now - start_time
  puts "#{description}: #{duration} seconds"
end

profile '100000 doublings' do
  number = 1
  100000.times { number *= 2 }
  puts "#{number.to_s.length} digits"   # 30103 digits
end                                     # 100000 doublings:  0.245181828 seconds

profile 'count to a million' do
  number = 0  
  1000000.times { number += 1 }
end                                     # count to a million:  0.057925794 seconds

# to make it run with a proc remove the '&'

# count_million = Proc.new do
#   number = 0
#   1000000.times { number += 1 }
# end

# profile "count with proc", count_million