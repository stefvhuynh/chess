require_relative "piece"

class Pawn < Piece
  
  SYMBOLS = {
    :white => " ♙ ",
    :black => " ♟ "
  }
  
  DELTAS = {
    :white => [ [-1, 0],
                [-2, 0], 
                [-1, 1], 
                [-1, -1] ],
                
    :black => [ [1, 0], 
                [2, 0],
                [1, 1], 
                [1, -1] ]
  }
  
  def possible_moves
    [].tap do |possible_moves|
      all_moves.each_with_index do |move, index|
        # Only include the front position as a possible move if it's empty.
        if index == 0 && @board.pos_empty?(move)
          possible_moves << move
        # Only include the double move if the path is clear and the pawn has
        # not moved yet.
        elsif index == 1 && @board.pos_empty?(all_moves[0]) && 
              @board.pos_empty?(move) && self.move_history.length == 1
        possible_moves << move      
        # Include diagonal positions if they are occupied by an opponent's 
        # piece.
        elsif !@board.pos_empty?(move) && @board.valid_move?(move, self.color)
          possible_moves << move
        end
      end
    end
  end
  
  def all_moves
    [].tap do |all_moves|
      DELTAS[self.color].each_with_index do |(d_row, d_col), index|
        all_moves << [self.position[0] + d_row, self.position[1] + d_col]
      end
    end
  end
  
  def render
    SYMBOLS[self.color]
  end
  
end


