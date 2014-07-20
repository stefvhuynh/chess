require_relative "piece"

class Pawn < Piece
  
  SYMBOLS = {
    :white => " ♙ ",
    :black => " ♟ "
  }
  
  # The order in which the DELTAS are arranged is important to 
  # Pawn#possible_moves.
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
      moves = all_pawn_moves
        
      if @board.valid_pawn_move?(moves[0])
        possible_moves << moves[0]
        # This is only valid if the single move is also valid.
        if @board.valid_pawn_move?(moves[1]) && self.move_history.length == 1
          possible_moves << moves[1]
        end
      end
    
      moves[2..3].each do |move|
        possible_moves << move if @board.valid_pawn_attack?(move, self.color)
      end
    end
  end
  
  def all_pawn_moves
    [].tap do |moves|
      DELTAS[self.color].each do |(d_row, d_col)|
        moves << [self.position[0] + d_row, self.position[1] + d_col]
      end
    end
  end
  
  def render
    SYMBOLS[self.color]
  end
  
end


