require_relative 'game'

# to run these tests the private Game methods must be made public

describe Game do

  before do 
    @x = Player.new("X")
    @o = Player.new("O")
    @game = Game.new(@x,@o)
  end

  describe "won_by_column?" do

    it "should return false if there are no matches" do
      @game.game_state = [['1', '2', '3'],
                          ['4', '5', '6'],
                          ['7', '8', '9']]
      expect(@game.won_by_column?(@x)).to eq(false)
    end

    it "should return true given o if O fills first column" do
      @game.game_state = [['O', '2', '3'],
                          ['O', '5', '6'],
                          ['O', '8', '9']]
      expect(@game.won_by_column?(@o)).to eq(true)
    end

    it "should return true given o if O fills the second column" do
      @game.game_state = [['1', 'O', '3'],
                          ['4', 'O', '6'],
                          ['7', 'O', '9']]
      expect(@game.won_by_column?(@o)).to eq(true)
    end

    it "should return true given x if X fills the last column" do
      @game.game_state = [['1', '2', 'X'],
                          ['2', '5', 'X'],
                          ['3', '8', 'X']]
      expect(@game.won_by_column?(@x)).to eq(true)
    end
  end

  describe "won_by_row?" do
    
    it "should return false if there are no matches" do
      @game.game_state = [['1', '2', '3'],
                          ['4', '5', '6'],
                          ['7', '8', '9']]
      expect(@game.won_by_row?(@x)).to eq(false)
    end

    it "should return true given x if X fills the first row" do
      @game.game_state = [['X', 'X', 'X'],
                          ['4', '5', '6'],
                          ['7', '8', '9']]
      expect(@game.won_by_row?(@x)).to eq(true)
    end

    it "should return true given x if X fills the second row" do
      @game.game_state = [['1', '2', '3'],
                          ['X', 'X', 'X'],
                          ['7', '8', '9']]
      expect(@game.won_by_row?(@x)).to eq(true)
    end

    it "should return true given o if O fills the third row" do
      @game.game_state = [['1', '2', '3'],
                          ['4', '5', '6'],
                          ['O', 'O', 'O']]
      expect(@game.won_by_row?(@o)).to eq(true)
    end
  end

  describe "won_by_diagonal?" do
    it "should return false if there are no matches" do
      @game.game_state = [['1', '2', '3'],
                          ['4', '5', '6'],
                          ['7', '8', '9']]
      expect(@game.won_by_diagonal?(@x)).to eq(false)
    end

    it "should return true given o if O fills first diagonal" do
      @game.game_state = [['O', '2', '3'],
                          ['4', 'O', '6'],
                          ['7', '8', 'O']]
      expect(@game.won_by_diagonal?(@o)).to eq(true)
    end

    it "should return true given x if X fills the second diagonal" do
      @game.game_state = [['1', '2', 'X'],
                          ['4', 'X', '6'],
                          ['X', '8', '9']]
      expect(@game.won_by_diagonal?(@x)).to eq(true)
    end
  end

  describe "tie?" do
    it "should return false if there are remaining moves" do
      @game.game_state = [['1', '2', '3'],
                          ['4', '5', '6'],
                          ['7', '8', '9']]
      expect(@game.tie?).to eq(false)
    end

    it "should return true if there are no remaining moves" do
      @game.game_state = [['X', 'O', 'O'],
                          ['O', 'X', 'X'],
                          ['X', 'X', 'O']]
      expect(@game.tie?).to eq(true)
    end
  end
end