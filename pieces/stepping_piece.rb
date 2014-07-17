require_relative "piece"

class SteppingPiece < Piece
  
  def possible_moves
    possible_moves = []
    
    # Subclass#move_deltas (King and Knight)
    move_deltas.each do |(drow, dcol)|
      possible_moves << [self.position[0] + drow, self.position[1] + dcol]
    end
    
    # Piece#in_bounds? and Piece#valid_move?
    possible_moves.select { |move| in_bounds?(move) && valid_move?(move) }
  end
  
end