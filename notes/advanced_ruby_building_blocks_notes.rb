# spaceship operator
1<=>10                      # => -1
1<=>1                       # => 0
1<=>-10                     # => 1

# useful in sorting operations
def Person
  # compare people's last names
  def <=> (other_person)
    self.last_name <=> other_person.last_name
  end
end

# build your own each method
class Array
  def my_each
    i = 0
    while i < self.size
      # yields to the block passed to my_each
      # block_given? does what it says on the can
      yield self[i] if block_given?
      i += 1
    end
    self
  end
end

# blocks are to procs as anonymous functions are to methods
#   you cannot use explicit `return in a proc`
my_proc = Proc.new { |arg1| print "#{arg1}!"}
[1,2,3].each &my_proc


# blocks and procs are closures
# you can assign a closure persistant vars the first time you call it
# procs are to lambdas as blocks are to procs
#   procs are closer to methods, but still anonymous functions
#   you CAN use explicit `return` in lambdas
#   stricter about accepting the right number of args
lambda do |word|
  puts word
  return word
end.call("howdy")             # howdy => "howdy"

# Methods are a way of passing an honest to god method to another method
# Methods are another form of closure
class Array
  def my_each some_method
    i = 0
    while i < self.size
      some_method.call self[i]
      i += 1
    end
  end
  self
end
def print_stuff word
  print "#{word}!"
end
[1,2,3].my_each(method(:print_stuff))   # symbolize the name
# 1! 2! 3! => nil



# other enumerables
# select SELECTS elements (acts as a filter)
my_array = [1,2,3,4]
my_array.select { |item| item % 2 == 0 }
# => [2,4]

# map reMAPs modified elements
my_array.map { |item| item**2 }
# => [1,4,9,16]

# any? checks if ANY elems match condition
# none? == ! any?
my_array.any? { |item| item == 3 }
# => true

# all? checks if ALL elems match condition
my_array.all? { |item| item.class = Fixnum}
# => true

# find FINDs first elem that matches condition
my_array.find { |item| item % 2 }
# => 2

# group_by GROUPS elems BY return value of block
names = %w(james bob joe mark jim)
names.group_by { |name| name.length }
# => 5=>["james"], 3=>["bob", "joe", "jim"], 4=>["mark"]

# grep match regex criteria using ===
names.grep(/j/)
# => ["james", "joe", "jim"]


class User
  def jump
    # self is the object that calls the method
    "#{self.first_name} is in the air"
  end
end
current_user = User.new
current_user.jump



# the shebang line lets you execute code set to be executable
# it is the first line of the code (the hash is included):
#!/usr/bin/ruby



# in irb use `load './your_script'` to reload after it has already been required



# Special constants

__FILE__              # the name of the current file

$0                    # main/original file that was run

$                     # AKA $LOAD_PATH
                      # arr with all dirs the interpertter searches for files

if $0 == __FILE__
  puts "I'm a command line script right now!"
else
  puts "Someone else is running me"
end



# call a variable method with #send
class Klass
  def hello string
    "Hello #{string}"
  end
end
k = Klass.new
k.send :hello, "gentle readers"     # => "Hello gentle readers"