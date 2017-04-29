require 'spec_helper'
require 'tic2'

describe Position do
  context "#new" do
    it "should initialize a new position" do
      expect(Position.new.board).to eq(%w(-) * 9)
      expect(Position.new.turn).to eq("x")
    end
  end

end
