# exceptions

# raise a generic error
  class Person
    def initialize name
      raise ArgumentError, "No name present" if name.empty?
    end
  end

# create and raise a custom error
  class BadDataException < RunTimeError; end
  class Person
    def initialize name
      raise BadDataException, "No name present" if name.empty?
    end
  end

# basic error handling with begin/rescue blocks
  begin
    # your code
  rescue ZeroDivisionError
    # if exception is ZeroDivisionError
  rescue YourOwnException => e
    # if exception is YourOwnException
    # e recieves the exception to let us play with it
    #   e is always optional
    #   this could let you run methods of the exception!
  rescue => e
    # for all other errors
  end

# throw and catch to escape loops
# when an error occurs the code traces up the stack until it can find a catch
# if none is found the program crashes
  catch :finish do
    1000.times do
      x = rand 1000
      throw :finish if x == 123
    end
    puts "Generated 1000 numbers without generating 123"
  end

# throw works for methods called within the catch block
  def generate_random_number_except_123 do
    x = rand 1000
    throw :finish if x == 123
  end
  catch :finish do
    1000.times { generate_random_number_except_123 }
    puts "Generated 1000 numbers without generating 123"
  end