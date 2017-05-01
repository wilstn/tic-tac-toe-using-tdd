require './lib/position.rb'

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
