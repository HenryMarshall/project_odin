require_relative 'player'

class Game

  # required for testing purposes
  attr_accessor :game_state

  def initialize x, o
    @game_state =  [['1', '2', '3'],
                    ['4', '5', '6'],
                    ['7', '8', '9']]
    @players = [x, o]
  end

  # launch the game
  def play_game
    randomize_first_player()
    while true
      @players.each do |player|
        begin
          round(player)
        rescue => e
          puts e
          redo
        end
      end
    end
  end

  # all private functions must be made public for unit tests to work
  # private

  def round player
    draw_game()
    puts "#{player.name}'s Turn"
    position = convert_input_to_array_position(player.pick_square)
    
    if square_used?(position)
      raise "Square already used"
    else
      map_placement!(position, player) 
    end

    won?(player)
    tie?()
  end

  def randomize_first_player
    @players.shuffle!
  end

  def draw_game
    divider = "-+-+-"
    @game_state.each_with_index do |row, idx|
      puts row.join('|')
      puts divider unless idx == 2
    end
  end

  def convert_input_to_array_position input
    row = (input-1) / 3
    col = (input-1) % 3
    {row: row, col: col}
  end

  # place player mark on @game_state
  def map_placement! position, player
    @game_state[position[:row]][position[:col]] = player.name
  end

  def square_used? position
    value_in_position = @game_state[position[:row]][position[:col]]
    @players.any? { |player| player.name == value_in_position }
  end

  def tie?
    return @game_state.all? do |row|
      # if none are digits cannot go (true)
      row.none? { |cell| cell.to_i != 0 }
      draw_game()
      puts "----------------"
      puts "A tie. How predictable"
      exit
    end
  end

  def won? player
    victory_conditions = [won_by_row?(player), won_by_column?(player),
                          won_by_diagonal?(player)]
    if victory_conditions.any?
      draw_game()
      puts "---------------"
      puts "#{player.name} Won!"
      exit
    end
  end

  def won_by_row? player
    return @game_state.any? do |row|
      row.all? { |cell| cell == player.name }
    end
  end

  def won_by_column? player
    return 3.times.any? do |col|
      @game_state.all? { |row| 
        row[col] == player.name
      }
    end
  end

  def won_by_diagonal? player
    diagonals = [[{row:0, col:0}, {row:1, col:1}, {row:2, col:2}],
                 [{row:0, col:2}, {row:1, col:1}, {row:2, col:0}]]
    return diagonals.any? do |diagonal|
      diagonal.all? do |cell|
        @game_state[cell[:row]][cell[:col]] == player.name
      end  
    end
  end

end

# if run from the command prompt start a game
if $0 == __FILE__
  x = Player.new("X")
  o = Player.new("O")
  game = Game.new(x,o)
  game.play_game
end