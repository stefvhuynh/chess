require_relative "stepping_piece"

class Knight < SteppingPiece
  
  UNICODE = {
    :white => "♘",
    :black => "♞"
  }
  
  def render
    UNICODE[self.color]
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


