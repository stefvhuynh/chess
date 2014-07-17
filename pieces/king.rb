require_relative "stepping_piece"

class King < SteppingPiece
  
  UNICODE = {
    :white => "♔",
    :black => "♚"
  }
  
  def render
    UNICODE[self.color]
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


