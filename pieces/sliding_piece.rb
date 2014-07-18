require_relative "piece"

class SlidingPiece < Piece
  
  def possible_moves
    possible_moves = []
    
    # Subclass#move_dirs (Queen, Bishop, Rook)
    move_dirs.each do |(dir_row, dir_col)|
      multiple = 1
      
      loop do
        move = [ self.position[0] + dir_row * multiple, 
                 self.position[1] + dir_col * multiple ]
        
        if @board.valid_move?(move, self.color)
          possible_moves << move
          multiple += 1
          # Break if move was valid (move was not occupied by piece of own
          # color) but was, nevertheless, occupied (by other color)
          break if !@board.pos_empty?(move)
        else
          break
        end
      end # Close loop
    end # Close .each
    
    possible_moves
  end
  
end


