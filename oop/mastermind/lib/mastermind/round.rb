module Mastermind

  class Round

    def initialize codemaker, codebreaker
      @guesses = 8
      @codebreaker = codebreaker
      @codemaker = codemaker
      @answer_pegs = @codemaker.create_solution

      empty = "| | | | || | | | |"
      @table  = Array.new(@guesses, empty)
    end

    def play_round
      @guesses.times do |round|
        begin
          guess_pegs = @codebreaker.make_guess(round)
          guess = Guess.new(guess_pegs)
        rescue => e
          puts e
          sleep 1
          redo
        else
          result_pegs = guess.get_results(@answer_pegs)
          update_table!(guess_pegs, result_pegs, round)
          print_game()
          break if round_over?(result_pegs, round)
        end
      end
    end

    def print_game
      header  = "|Guesses||Results|"
      divider = "|-+-+-+-||-+-+-+-|"
      puts header
      @table.reverse.each do |row|
        puts(divider)
        puts(row)
      end
      puts(divider)
    end

    def update_table!(guess_pegs, results_pegs, round)
      @table[round] = "|#{guess_pegs.join('|')}||#{results_pegs.join('|')}|"
    end

    def round_over?(result_pegs, round)
      won?(result_pegs) || lost?(round)
    end

    def won? result_pegs
      if result_pegs == Array.new(4, "X")
        @codebreaker.wins += 1
        puts "#{@codebreaker.name} Won"
        puts "-------------"
        true
      else
        false
      end
    end

    def lost? round
      if round >= @guesses
        puts "#{@codebreaker.name} Lost"
        puts "-------------"
        true
      else
        false
      end
    end

  end
end