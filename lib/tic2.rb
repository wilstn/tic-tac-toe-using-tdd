class Position
  attr_accessor :board, :turn

  def initialize(board=nil, turn="x")
    @board = %w(-) * 9 || board
    @turn = turn
  end
end
