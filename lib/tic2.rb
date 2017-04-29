class Position
  attr_accessor :board, :turn

  def initialize(board=nil, turn="x")
    @board = board || %w(-) * 9
    @turn = turn
  end

  def change_turn(o, x)
    @turn == "x" ? o : x
  end

  def move(index)
    @board[index] = @turn
    @turn = change_turn("o", "x")
    self
  end

  def possible_moves
    @board.each_index.select {|i| @board[i] == "-"}
  end

end
