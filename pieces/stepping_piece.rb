require_relative "piece"

class SteppingPiece < Piece
  
  def possible_moves
    possible_moves = []
    
    # Subclass#move_deltas (King and Knight)
    move_deltas.each do |(d_row, d_col)|
      possible_moves << [self.position[0] + d_row, self.position[1] + d_col]
    end
    
    # Piece#in_bounds? and Piece#valid_move?
    possible_moves.select { |move| in_bounds?(move) && valid_move?(move) }
  end
  
end