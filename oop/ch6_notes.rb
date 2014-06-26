# oop

# class variables denoted by @@

@@class_var = foo

# class methods

class Square
  def self.test_method
    puts "Hello from the square class"
  end
  def test_method
    puts "Hello from an instance of class Square"
end

Square.test_method              # Hello from the square class
Square.new.test_method          # Hello from an instance of class Square

# see what methods an oject has with #methods

"string".methods

# encapsulation is the ability to make certain methods always accessible and others only by the other methods of the class
# private

class Person
  def this_is_public; end
  private
  def this_is_private; end
end

class Person
  def this_is_public; end
  private
  def this_is_private; end
  public
  def this_is_also_public; end
end

class Person
  def this_is_public; end
  def this_is_private; end
  def this_is_also_private; end
  # must come after the methods are defined
  private :this_is_private, :this_is_too
end

# `protected` methods can be called from within the scope of any member
# of that class

class Person
  def initialize(age); @age = age; end
  def age_difference_with(other_person)
    (self.age - other_person.age).abs
  end
  protected
  def age; @age; end
end
fred = Person.new(34)
chris = Person.new(25)
puts chris.age_difference_with(fred)


# polymorphism is the ability to make an identically named method do different things for different classes
puts 1000.to_s
puts [1,2,3].to_s
puts ({name: "fred", age: 10}).to_s


# nested classes

class Drawing
  def self.give_me_a_circle
    Circle.new
  end
  class Circle
    def what_am_i
      "This is a circle"
    end
  end
end

a = Drawing.give_me_a_circle
puts a.what_am_i                  # This is a circle
a = Drawing::Circle.new
puts a.what_am_i                  # This is a circle
a = Circle.new
puts a.what_am_i                  # => NameError



# modules, namespaces and mixins
# modules

module ToolBox
  class Ruler
    attr_accessor :length
  end
end
module Country
  class Ruler
    attr_accessor :name
  end
end
a = ToolBox::Ruler.new
a.length = 50
b = Country::Ruler.new
b.name = "Ghengis Khan"

# mixins

module UsefulFeatures
  def fooer
    "foo"
  end
end
class Person
  include UsefulFeatures
end
fred = Person.new
puts fred.fooer                     # foo

UsefulFeatures.fooer                # foo

include UsefulFeatures
fooer                               # foo
