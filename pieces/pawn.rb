require_relative "piece"

class Pawn < Piece
  
  SYMBOLS = {
    :white => " ♙ ",
    :black => " ♟ "
  }
  
  def render
    SYMBOLS[self.color]
  end
  
end


