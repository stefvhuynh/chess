require_relative "sliding_piece"

class Bishop < SlidingPiece
  
  SYMBOLS = {
    :white => "♗",
    :black => "♝"
  }
  
  def render
    SYMBOLS[self.color]
  end

  def move_dirs
    [
      [ 1,  1], [ 1, -1],
      [-1, -1], [-1,  1]
    ]
  end
  
end


