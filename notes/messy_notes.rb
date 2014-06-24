# var names should use meaning of contents not type of contents
#   `students` not `students_arr`

# set rand seed with srand

srand 1776
first_runthrough = rand(100)
srand 1776
second_runthrough = rand(100)
# always true
first_runthrough == second_runthrough

# reset with `srand 0`

hr = Time.now.hour
am_pm = hr % 12
am_pm = 12 if am_pm == 0
am_pm.times do
  puts "Dong"
end

class Die
  def initialize
    roll
  end

  def cheat val
    @number_showing = val unless val > 6

  def roll
    @number_showing = 1 + rand(6)
  end

  def showing
    @number_showing
  end
end

# woah procs!
toast = Proc.new do
  puts 'Cheers'
end
toast.call          # > Cheers

do_you_like = Proc.new do |thing|
  puts "I love #{thing}!"
end
do_you_like.call 'ruby'

def interupt_this some_proc
  puts 'doing something when suddenly'
  some_proc.call
  puts 'back to what i was doing'
end
interupt_this do_you_like("foo")

# .inspect is similar to .to_s
# tries to show you the ruby code for building the object you passed it

def compose proc1, proc2
  Proc.new do |x|
    proc2.call(proc1.call(x))
  end
end
square = Proc.new { |x| x ** 2 }
double = Proc.new { |x| x * 2  }

double_then_square = compose double, square
square_then_double = compose square, double
puts double_then_square.call(5)
puts square_then_double.call(5)

# pass a block into a method
def profile description, &block
  start_time = Time.now
  block.call
  duration = Time.now - start_time
  puts "#{description}: #{duration} seconds"
end

profile '25000 doublings' do
  number = 1
  25000.times { number *= 2 }
  puts "#{number.to_s.length} digits"   # 7526 digits
end                                     # 25000 doublings:  0.246768 seconds

profile 'count to a million' do
  number = 0  
  1000000.times { number += 1 }
end                                     # count to a million:  0.90245 seconds