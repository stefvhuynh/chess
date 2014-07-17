require_relative "piece"

class Pawn < Piece
  
  UNICODE = {
    :white => "♙",
    :black => "♟"
  }
  
  def render
    UNICODE[self.color]
  end
  
end


