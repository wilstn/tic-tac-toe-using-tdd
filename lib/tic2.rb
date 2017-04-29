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

  def win(player)
    winning_positions = [ [0,1,2],
                          [3,4,5],
                          [6,7,8],
                          [0,3,6],
                          [1,4,7],
                          [2,5,8],
                          [0,4,8],
                          [2,4,6] ]

    winning_positions.each do |line|
      counter = 0
      line.each do |i|
        counter += 1 if @board[i] == player
      end
      return true if counter == 3
    end
    return false
  end

end
