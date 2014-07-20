require_relative "board"
require_relative "user_error"
require "yaml"

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
  
    until @board.checkmate?(@turn) || @board.stalemate?(@turn)
      @board.display
      puts "#{@turn.upcase} to move."
      
      begin
        begin
          start_pos, end_pos = user_input
          
          if start_pos == "SAVE"
            save_game
            puts "Game succesfully saved!"
            return
          end
          
          raise UserError if @board.pos_empty?(start_pos)
          raise UserError if @board[start_pos].color != @turn
        rescue UserError
          puts "Please select one of your pieces!"
          retry
        end
        
        unless @board.non_check_move?(@board[start_pos], end_pos)
          raise IllegalMoveError 
        end
        @board[start_pos].move(end_pos)
      rescue IllegalMoveError
        puts "That's not a valid move!"
        retry
      end
      
      next_turn
    end
    
    @board.display
    puts @board.checkmate?(@turn) ? "#{next_turn.upcase} wins!" : "Stalemate!"
  end
  
  def user_input
    begin
      print "Enter starting and ending positions (ex: B8 C6): "
      user_input = gets.chomp.upcase
      raise UserError if user_input !~ /^[A-Z]{1}\d{1}\s[A-Z]{1}\d{1}$|^SAVE$/
    rescue UserError
      puts "Please enter valid characters!"
      retry
    end
    
    return user_input if user_input == "SAVE"
    
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
  
  def save_game
    print "Please name your save file: "
    filename = gets.chomp.downcase
    File.write("#{filename}.yml", YAML.dump(self))
  end
  
end

if __FILE__ == $PROGRAM_NAME
  begin
    print "Would you like to load a saved game or start a new one (load/new)? "
    input = gets.chomp.upcase
    raise UserError unless input != "LOAD" || input != "NEW"
  rescue UserError
    puts "Please type 'load' or 'new'!"
    retry
  end
  
  if input == "NEW"
    Chess.new.play
  else
    print "What is the name of your save file? "
    filename = gets.chomp.downcase
    YAML.load_file("#{filename}.yml").play
  end
end




