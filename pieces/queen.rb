require_relative "sliding_piece"

class Queen < SlidingPiece
  
  UNICODE = {
    :white => "♕",
    :black => "♛"
  }
  
  def render
    UNICODE[self.color]
  end

  def move_dirs
    [
      [0,  1], [ 0, -1],
      [1,  0], [-1,  0],
      [1, -1], [-1,  1],
      [1,  1], [-1, -1]
    ]
  end
  
end


