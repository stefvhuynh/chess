require_relative "board"
require_relative "user_error"

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
        begin
          start_pos, end_pos = user_input
          raise UserError if @board.pos_empty?(start_pos)
          raise UserError if @board[start_pos].color != @turn
        rescue UserError
          puts "Please select one of your pieces!"
          retry
        end
        
        @board[start_pos].move(end_pos)
      rescue IllegalMoveError
        puts "That's not a valid move!"
        retry
      end
      
      next_turn
    end
    
    @board.display
    puts "#{next_turn.upcase} wins!"
  end
  
  def user_input
    begin
      print "Enter starting and ending positions (ex: B8 C6): "
      user_input = gets.chomp.upcase
      raise UserError if user_input !~ /^[A-Z]{1}\d{1}\s[A-Z]{1}\d{1}$/
    rescue UserError
      puts "Please enter valid characters!"
      retry
    end
    
    user_input.split(/ /).map do |input|
      transformed = input.split(//).reverse
      transformed[0] = 8 - transformed[0].to_i
      transformed[1] = COLUMNS[transformed[1].to_sym]
      transformed
    end
  end
  
  def next_turn
    @turn = (@turn == :white) ? :black : :white
  end
  
end

Chess.new.play


