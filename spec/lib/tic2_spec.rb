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

  context "#possible_moves" do
    it "should check for possible moves" do
      position = Position.new.move(0).move(1)
      expect(position.possible_moves).to eq((2..8).to_a)
    end
  end

  context "#win" do
    it "should check if position is won for player x/o" do
      position1 = Position.new(%w(x x x o - o - - -), "o")
      position2 = Position.new(%w(x - - o x o - - x), "o")
      position3 = Position.new(%w(x - - x o o x - -), "o")
      position4 = Position.new(%w(- - x o x o x - -), "o")
      position5 = Position.new(%w(x x - o x o - - -), "o")
      expect(position1.win("x")).to be true
      expect(position2.win("x")).to be true
      expect(position3.win("x")).to be true
      expect(position4.win("x")).to be true
      expect(position5.win("x")).to be false
    end
  end

  context "#minimax" do
    it "should evaluate to 100 for a win for x" do
      position = Position.new(%w(x x x o o - - - -), "x")
      expect(position.minimax).to eq(100)
    end

    it "should evaluate to -100 for a loss for x" do
      position = Position.new(%w(x x - o o o x x -), "o")
      expect(position.minimax).to eq(-100)
    end

    it "should evaluate to 0 for a draw" do
      position = Position.new(%w(x o x x o o o x x), "o")
      expect(position.minimax).to eq(0)
    end
  end

end
