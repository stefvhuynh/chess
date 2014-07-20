require_relative "board"

class Chess
  
  COLUMNS = {
    :A => 0,
    :B => 1,
    :C => 2,
    :D => 3,
    :E => 4,
    :F => 5,
    :G => 6,
    :H => 7
  }
  
  def initialize
    @board = Board.new
    @turn = :white
  end
  
  def play
  
    until @board.checkmate?(@turn)
      @board.display
      puts "#{@turn.upcase} to move."
      
      begin
        start_pos, end_pos = user_input
        @board[start_pos].move(end_pos)
      rescue IllegalMoveError
        puts "That's not a valid move!"
        retry
      end
      
      next_turn
    end
    
    @board.display
  
  end
  
  def user_input
    print "Enter starting and ending positions (ex: B8 C6): "
    user_input = gets.chomp.split(/ /)
    user_input.map do |input|
      transformed = input.split(//).reverse
      transformed[0] = 8 - transformed[0].to_i
      transformed[1] = COLUMNS[transformed[1].upcase.to_sym]
      transformed
    end
  end
  
  def next_turn
    @turn = (@turn == :white) ? :black : :white
  end
  
end

Chess.new.play


