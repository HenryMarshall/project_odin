# use #method to talk about instance methods
# use ::method to talk about class methods

# read and write attributes
  attr_reader health
  attr_writer health
# combination of the reader and writer
  attr_accessor health

class Viking
  def take_damage damage
    @health -= damage
    # or self.health -= damage
    shout "OUCH!"
  end
  def shout str
    puts str
  end
end

# factory methods help you make instances
  class Viking
    def initialize name, health, age, strength
      # set the variables
    end
    def self.create_warrior name
      age = rand(20) + 15
      health = [age*5, 120].min 
      strength = [age/2, 10].min
      Viking.new(name, health, age, strength)
    end
  end
  sten = Viking.create_warrior "Sten"

# other time all vikings need an action
# i don't understand why you wouldn't use an instance method
  class Viking
    def self.silver_to_gold silver_pieces
      silver_pieces / 10
    end
  end


# inheritance
# Viking can be said to extend Person

  class Person
    MAX_HEALTH = 120
    # an init function
    def heal
      self.health = [self.health + 1, MAX_HEALTH].min
    end
  end
  class Viking < Person
    def initialize name, health, age, strength, weapon
      super(name, health, age, strength)
      @weapon = weapon
    end
    def heal
      2.times { super }     # vikings heal twice as fast
    end
  end