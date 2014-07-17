require_relative "stepping_piece"

class King < SteppingPiece
  
  def move_deltas
    [
      [0,  1], [ 0, -1],
      [1,  0], [-1,  0],
      [1, -1], [-1,  1],
      [1,  1], [-1, -1]
    ]
  end
  
end

