require 'spec_helper'

module Mastermind
  describe Player do
    context '#initialize' do
      it "is initialized with the name passed as an arg" do
        player = Player.new("Alice")
        expect(player.name).to eq("Alice")
      end
    end
  end

  describe HumanPlayer do

  end

  describe ComputerPlayer do

  end
end