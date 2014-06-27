module Mastermind

  class Game

    attr_reader :rounds

    def initialize player1, player2
      @rounds = 4
      @player1 = player1
      @player2 = player2
    end

    def start_game
      codebreaker, codemaker = @player1, @player2
      @rounds.times do
        round = Round.new(codebreaker, codemaker)
        round.play_round
        codebreaker, codemaker = codemaker, codebreaker
      end
    end

    def self.format_pegs pegs_string
      pegs = pegs_string.split('').map { |peg| peg.to_i }
      pegs if Game.valid_pegs?(pegs)
    end

    def self.valid_pegs? pegs
      return true if pegs.length == 4 and pegs.all? do |peg|
        1 <= peg and peg <= 6
      end
      raise "Invalid peg selection -- choices are: 1-6"
    end
  end
end