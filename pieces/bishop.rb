require_relative "sliding_piece"

class Bishop < SlidingPiece
  
  UNICODE = {
    :white => "♗",
    :black => "♝"
  }
  
  def render
    UNICODE[self.color]
  end

  def move_dirs
    [
      [ 1,  1], [ 1, -1],
      [-1, -1], [-1,  1]
    ]
  end
  
end


