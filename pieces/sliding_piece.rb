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
        # Piece#in_bounds and Piece#valid_move?
        if in_bounds?(move) && valid_move?(move)
          possible_moves << move
          multiple += 1
        else
          break
        end
      end # Close loop
    end # Close .each
    
    possible_moves
  end
  
end


