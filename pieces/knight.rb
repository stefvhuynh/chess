require_relative "stepping_piece"

class Knight < SteppingPiece
  
  SYMBOLS = {
    :white => "♘",
    :black => "♞"
  }
  
  def render
    SYMBOLS[self.color]
  end
  
  def move_deltas 
    [
      [ 1,  2], [ 2,  1],
      [ 2, -1], [ 1, -2],
      [-1, -2], [-2, -1],
      [-2,  1], [-1,  2]
    ]
  end
  
end


