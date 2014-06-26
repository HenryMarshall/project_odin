class Player

  attr_accessor :name

  def initialize name
    @name = name
  end

  # pick where you want to go
  def pick_square
    input = gets.chomp.to_i
    puts "\n\n"
    input
  end

end