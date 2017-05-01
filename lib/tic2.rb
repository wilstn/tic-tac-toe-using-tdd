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
    # puts "#{@@minimax}" if defined? @@minimax
    # binding.pry
    return 100 if win("x")
    return -100 if win("o")
    return 0 if possible_moves.empty?

    @@minimax ||= {}
    value = @@minimax[@board]
    return value if value
    # if none of the base cases are hit, call minimax on each of the possible move recursively
    # until a base case is hit, returning 100, -100 or 0 for the move.
    # eg, for each board position, one of the results in @@minimax:
    # ["x", "x", "-", "o", "o", "x", "o", "-", "x"]=>[-100, [100]] -100 indicate a loss if "o" takes index position 2
    # while +100 win for "x" if "o" takes index position 7. This current board position with 4 x and 3 o indicates its o's turn
    # Given this result, "o" will choose index 7 and this is done by method: send(change_turn(:max, :min)) which seeks to maximise
    # or minimise the return value depending on whose turn it is. As such, this board position will have a point of -100
    @@minimax[@board] = possible_moves.map { |possible_space|
      # puts "whose turn: #{turn}\nmove: #{possible_space}\npoints: #{move(possible_space).minimax}"
      move(possible_space).minimax
    }.send(change_turn(:max, :min))
  end

  # this method seeks to select the possible move (index number to make move) that minimise/maximise the result of above minimax method
  # depending on whose turn it is.
  def best_move
    possible_moves.send(change_turn(:max_by, :min_by)) {|idx| move(idx).minimax}
  end

end

class Game
  def get_player_input(position)
    while true
      print "Enter position 1-9: "
      user_input = gets.to_i - 1
      return user_input if position.possible_moves.include?(user_input)
    end
  end

  def render_board(board)
    puts "#{board[0].gsub(/-/, " ")} | #{board[1].gsub(/-/, " ")} | #{board[2].gsub(/-/, " ")}"
    puts "------------"
    puts "#{board[3].gsub(/-/, " ")} | #{board[4].gsub(/-/, " ")} | #{board[5].gsub(/-/, " ")}"
    puts "------------"
    puts "#{board[6].gsub(/-/, " ")} | #{board[7].gsub(/-/, " ")} | #{board[8].gsub(/-/, " ")}"
  end

  def play_game
    @position = Position.new(nil,"o")
    while true
      player_move = get_player_input(@position)
      @position = @position.move(player_move)
      
      if @position.possible_moves.empty?
        puts "no more move - draw"
        render_board(@position.board)
        break
      else
      end

      computer_move = @position.best_move
      @position = @position.move(computer_move)
      render_board(@position.board)

      if @position.win("o")
        puts "you win"
        render_board(@position.board)
        break
      elsif @position.win("x")
        puts "computer win"
        render_board(@position.board)
        break
      elsif @position.possible_moves.empty?
        puts "no more move - draw"
        render_board(@position.board)
        break
      else
      end

    end
  end
end

Game.new.play_game
