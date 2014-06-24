(1..4) === 3        # => true
  # thing on the right is a member/part/type of thing on left

# Everything is an object! OMG

4.methods             # -- discover methods
4.is_a?Integer        # => true

# methods on a class returns only class methods
String.methods          <  "foo".methods
String.instance_methods == "foo".methods

"hello" +  " world"   # => "hello world"
"hello" << " world"   # => "hello world"

# chomp removes (\n|\r) at end of line
# strip removes \s including (\n|\r)
player1 = gets.chomp

"foo".length          # => 3
"foo".reverse         # => "oof"
"foo".next            # => "fop"
"Foo".swapcase        # => "fOO"
"hello"[1]            # => "e"
"hello"[2..4]         # => "llo"

%q(hello
world)              # => "hello\nworld"
# delimeter is explicitly set to custom phrase (e.g., END_ME)
x = <<END_ME
Hello
World
END_ME

# symbols are immutable
# symbols are only stored in memory in one place
:symb.object_id == :symb.object_id
"str".object_id != "str".object_id

"hi".ljust(4)         # "hi  "
"hi".rjust(4,"*")     # "**hi"
"hi".center(4)        # " hi "

"hello".scan('l') { |x| print x}   # ll



Array.new(3)          # [nil, nil, nil]
# can also take a block that defines what goes in each spot
Array.new(3, "foo")   # ["foo", "foo", "foo"]

arr = (1..5).to_a
arr[1..3] == arr.slice(1..3)
arr[0..2] = 99        # => [99, 4, 5]

arr10 = [10, 11, 12]
arr20 = [20, 21, 22]
arr10 + arr20         # => [10, 11, 12, 20, 21, 22]

[1,2,3] - [2,3,4]     # => [1] -- 4 did nothing
[1,1,2] - [1]         # => [2]

# find duplicates
[1,2,3] & [2,3,4]     # => [2,3]

# arr resets to [1,2,3] on empty lines
arr = [1,2,3]
# push, unshift, pop, shift all modify in place
arr.push(4)           # [1,2,3,4]
arr << 5              # [1,2,3,4,5]
arr.unshift(0)        # [0,1,2,3,4,5]
arr.pop               # => 5
arr                   # => [0,1,2,3,4]
arr.shift             # => 0
arr                   # => [1,2,3,4]

# for all add methods 
arr << [4,5]      # => [1,2,3,[4,5]]

arr.delete_at(1)      # => 2
arr                   # => [1,3]

arr.include? 3        # => true
arr = [1,2,3,3]
arr.index 3           # => 2
arr.index 4           # => nil

# max -- finds max
# min -- finds min
# uniq -- removes duplicates
# sample -- picks a random value
# sort -- can take block to sort by

# length/size (aliases) are more efficient than count
arr.length            # => 3
# count uses an enumerable
arr.count             # => 3
arr.count{|x| x > 2}  # => 1



# delete an elem from a hash by setting to nil
my_hash = {foo: "foo", bar: "bar"}
my_hash[:bar] = nil
my_hash               # => {foo: "foo"}
my_hash.delete(:foo)  # => {}
my_hash.delete_if { |key,value| value == "bar" }

hash1 = {foo: "one", bar: "two"}
hash2 = {baz: "three", bar: "not_two"}
# note that "not_bar" overrides "bar" (it's from the arg hash)
# in place
hash1.merge(hash2)    # => {foo: "foo", bar: "not_bar", baz: "baz"}

hash2.keys            # => [:baz, :bar]
hash2.values          # => ["three", "not_two"]

# a "set" is a hash that only holds true or false -- it is very fast



Time.new == Time.now
vday = Time.new(2012,2,14)      # => 2012-02-14 00:00:00 -0800
vday+3600                       # => 2012-02-14 01:00:00 -0800
xmas = Time.new(2014,12,25)
Time.new - xmas                 # <seconds to christmas>
Time.new.ctime                  # => "Mon Jun 23 23:52:39 2014"
nownow.strftime("%Y-%m-%d %H:%M:%S")
                                # => "2014-06-24 03:53:04"



[].nil?                 # => false
[].first.nil?           # => true

# empty returns true if `thing.length == 0`
"".empty?               # => true
" ".empty?              # => false
nil.empty?              # => error
# only exists in rails
" ".blank?              # => true
nil.blank?              # => true
[nil, ''].blank?        # => false
[nil, ''].all? &:blank  # => true
var.blank? == !var.present?

# informative vs pretty
p "foo"                 # runs #inspect on "foo"
puts "foo"              # runs #to_s on "foo"

my_arr = [1,2,3,4]
my_arr[1], my_arr[3] = 100, 200
my_arr                  # => [1,100,3,200]

# swap vars
a,b = b,a



5.times {}
1.upto 5                # for 1,2,3,4,5
10.downto 5             # for 10,9,8,7,6,5
0.step(20,5)            # for 0,5,10,15,20



the_condition ? result_if_true : results_if_false

color = case fruit
when "orange"
  "orange"
when "apple"
  "red"
else
  "unknown"
end



def each_vowel(&code_block)
  %w(a e i o u).each { |vowel| code_block.call(vowel) }
end
each_vowel { |vowel| puts vowel}
# equivalent to
def each_vowel
  %w(a e i o u).each { |vowel| yield vowel }
end
each_vowel { |vowel| puts vowel }

# store code block in variable with lambda
# these are sometimes called Procs
print_param_to_screen = lambda { |x| puts x }
print_param_to_screen.call 100                    # => 100