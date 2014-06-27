module Mastermind

  class Guess

    def initialize guess_pegs
      @guess_pegs = guess_pegs
    end

    def get_results answer_pegs
      results = []
      black_pegs = count_black(answer_pegs)
      white_pegs = count_white(answer_pegs)
      black_pegs.times { results << "X" }
      white_pegs.times { results << "O" }
      (4 - black_pegs - white_pegs).times { results << " " }
      results
    end

    def count_black answer_pegs
      answer_pegs.each_with_index.count do |answer_peg, idx|
        answer_peg == @guess_pegs[idx]
      end
    end

    def count_white answer_pegs
      # create new arrays that lack black matches
      not_black_answer_pegs = []
      not_black_guess_pegs = []
      answer_pegs.each_with_index do |answer_peg, idx|
        if answer_peg != @guess_pegs[idx]
          not_black_answer_pegs << answer_peg
          not_black_guess_pegs  << @guess_pegs[idx]
        end
      end
      # find white matches amongst new arrays
      white_pegs = 0
      not_black_guess_pegs.each do |guess_peg|
        match = not_black_answer_pegs.index(guess_peg)
        unless match.nil?
          white_pegs += 1
          not_black_answer_pegs.delete_at(match)
        end
      end
      white_pegs
    end

  end
end