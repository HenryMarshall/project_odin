require_relative"./mastermind/version.rb"

module Mastermind
end

require_relative './mastermind/game.rb'
require_relative './mastermind/round.rb'
require_relative './mastermind/guess.rb'
require_relative './mastermind/player.rb'

# if run from the command prompt start a game
if $0 == __FILE__
  player1 = Mastermind::ComputerPlayer.new("Player1")
  player2 = Mastermind::HumanPlayer.new("Player2")
  game = Mastermind::Game.new(player1, player2)
  game.start_game
end