module Mastermind
  class Player
    attr_accessor :name, :wins
    def initialize name
      @name = name
      @wins = 0
    end
  end

  class ComputerPlayer < Player

    def create_solution
      # solution = []
      # 4.times { solution << rand(6) }
      [1,2,3,4]
    end

    def make_guess round
    end

  end

  class HumanPlayer < Player

    def create_solution
      get_input("secret solution")
    end

    def make_guess round
      get_input("guess")
    end

    private

    def get_input action
      puts "Make a #{action} #{self.name}"
      print "> "
      string = gets.chomp
      Game.format_pegs(string)
    end
  end

end