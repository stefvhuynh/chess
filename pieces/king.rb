require_relative "stepping_piece"

class King < SteppingPiece
  
  SYMBOLS = {
    :white => " ♔ ",
    :black => " ♚ "
  }
  
  def render
    SYMBOLS[self.color]
  end
  
  def move_deltas
    [
      [0,  1], [ 0, -1],
      [1,  0], [-1,  0],
      [1, -1], [-1,  1],
      [1,  1], [-1, -1]
    ]
  end
  
end


