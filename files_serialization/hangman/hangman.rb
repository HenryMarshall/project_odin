require 'byebug'
require 'json'

class Hangman

  def initialize
    @game = {}
    @game[:secret_word] = generate_secret_word()
    @game[:blanks] = generate_blanks(@game[:secret_word])
    @game[:max_wrong_guesses] = 6
    @game[:wrong_guesses] = 0
    @game[:guesses] = []
  end

  def start_game
    until lost?(@game[:wrong_guesses], @game[:max_wrong_guesses])
      prompt_user(@game[:max_wrong_guesses], @game[:wrong_guesses], @game[:blanks])
      user_input = guess_letter()
      # check if guess is a single alpha character
      if ('a'..'z').to_a.include?(user_input)
        letter = user_input
        if @game[:guesses].include?(letter)
          puts "You already guessed #{letter}"
        else
          if @game[:secret_word].include?(letter)
            @game[:blanks] = updated_blanks(@game[:blanks], @game[:secret_word],
                                            letter)
            won?(@game[:blanks], @game[:secret_word])
          else
            @game[:wrong_guesses] += 1
          end
          @game[:guesses] << letter
        end
      else
        parse_command(user_input)
      end
    end
    puts "You're Dead! The word was: #{@game[:secret_word]}"
    exit
  end

  # private

    def generate_secret_word
      file = open("assets/5desk.txt")
      words = file.readlines
      word = ""
      until (5 < word.length and word.length < 12)
        word = words.sample.strip
      end
      file.close
      word.downcase
    end

    def generate_blanks word
      Array.new(word.length, '_').join(' ')
    end

    def updated_blanks blanks, secret_word, letter
      secret_word.split('').each_with_index do |secret_letter, idx|
        if secret_letter == letter
          blanks[idx * 2] = letter
        end
      end
      blanks
    end

    def parse_command user_input
      if user_input == "--cheat"
        puts "The secret word is #{@game[:secret_word]}"
      elsif user_input == "--save"
        puts "Saving game..."
        save_game(@game)
        puts "Game saved"
      elsif user_input == "--load"
        puts "Loading saved game"
        load_game()
        puts "Game loaded"
      else
        puts "Invalid input"
      end
    end

    def save_game game_hash
      open('hangman_save_game.json', 'w') do |f|
        f.write JSON.generate(game_hash)
      end

    end

    def load_game
      byebug
      file = File.read('hangman_save_game.json')
      @game = JSON.parse(file)
    end

    def prompt_user max_wrong_guesses, wrong_guesses, blanks
      puts "Wrong guesses remaining: #{max_wrong_guesses - wrong_guesses}"
      puts blanks
    end

    def guess_letter
      puts "Pick a letter"
      print "> "
      gets.strip.downcase
    end

    def won? blanks, secret_word
      unless blanks.include? "_"
        puts "Congrats! You escaped the gallows! The word was #{secret_word}"
        exit
      end
    end

    def lost? wrong_guesses, max_wrong_guesses
      wrong_guesses >= max_wrong_guesses
    end

end

if $0 == __FILE__
  game = Hangman.new
  game.start_game
end