require_relative "sliding_piece"

class Rook < SlidingPiece
  
  UNICODE = {
    :white => "♖",
    :black => "♜"
  }
  
  def render
    UNICODE[self.color]
  end

  def move_dirs
    [
      [0,  1], [ 1, 0],
      [0, -1], [-1, 0]
    ]
  end
  
end


