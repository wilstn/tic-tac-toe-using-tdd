require 'spec_helper'
require 'tic2'

describe Position do
  context "#new" do
    it "should initialize a new position" do
      expect(Position.new.board).to eq(%w(-) * 9)
      expect(Position.new.turn).to eq("x")
    end

    it "should initialize a position given a board and turn" do
      position = Position.new(%w(x - - - - - - - -), "o")
      expect(position.board).to eq(%w(x - - - - - - - -))
      expect(position.turn).to eq("o")
    end
  end

  context "#move" do
    it "should make a move on board" do
      position = Position.new.move(0)
      expect(position.board).to eq(%w(x - - - - - - - -))
      expect(position.turn).to eq("o")
    end
  end

end
