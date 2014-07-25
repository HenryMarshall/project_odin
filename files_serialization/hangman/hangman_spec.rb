require_relative 'hangman.rb'

describe Hangman do

  before { @hangman = Hangman.new }

  context '#generate_blanks' do
    it "should generate as many blanks as letters in the word" do
      expect(@hangman.generate_blanks("foobar")).to eq("_ _ _ _ _ _")
    end
  end

  context '#update_blanks' do
    it "should fill in a single blank with the correct letter" do
      expect(@hangman.updated_blanks("_ _ _ _", "meet", "t")).to eq("_ _ _ t")
    end

    it "should fill in multiple blanks with the" do
      expect(@hangman.updated_blanks("_ _ _ _", "meet", "e")).to eq("_ e e _")
    end

    it "should fill in blank of partially completed solution" do
      expect(@hangman.updated_blanks("_ e e _", "meet", "t")).to eq("_ e e t")
    end
  end

  context '#won?' do
    it "should be false if there are remaining blanks" do
      expect(@hangman.won?("_ e e t")).to eq(false)
    end
    it "should be true if there are not more blanks" do
      expect(@hangman.won?("m e e t")).to eq(true)
    end
  end

  context '#lost?' do

    it "should be false if below max_wrong_answers" do
      expect(@hangman.lost?(4)).to eq(false)
    end

    it "should be true if equal max_wrong_answers" do
      expect(@hangman.lost?(6)).to eq(true)
    end

    it "should be true if above max_wrong_answers" do
      expect(@hangman.lost?(8)).to eq(true)
    end

  end

end