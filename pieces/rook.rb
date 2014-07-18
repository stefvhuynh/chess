require_relative "sliding_piece"

class Rook < SlidingPiece
  
  SYMBOLS = {
    :white => "♖",
    :black => "♜"
  }
  
  def render
    SYMBOLS [self.color]
  end

  def move_dirs
    [
      [0,  1], [ 1, 0],
      [0, -1], [-1, 0]
    ]
  end
  
end


