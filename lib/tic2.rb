class Position
  attr_accessor :board, :turn

  def initialize(board=nil, turn="x")
    @board = board || %w(-) * 9
    @turn = turn
  end

  def change_turn(o, x)
    # checks if current turn is x. if it is, returns o
    @turn == "x" ? o : x
  end

  def move(index)
    # move takes in current board and returns a new position after move
    # as otherwise minimax uses the same board
    position = Position.new(@board.dup, @turn)
    position.board[index] = position.turn
    position.turn = change_turn("o", "x")
    position
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

  def minimax
    # these are the base cases when game terminate with win, lose or draw
    # assuming x to be the computer, this would assign highest point to x winning
    return 100 if win("x")
    return -100 if win("o")
    return 0 if possible_moves.empty?

    # if none of the base cases are hit, call minimax on each of the possible move recursively
    # until a base case is hit
    kk = possible_moves.each do |possible_space|
      move(possible_space).minimax #.send(change_turn(:max, :min))
    end
    puts "#{kk}"

  end

end
