class Piece
  attr_reader :position, :color
  
  def initialize(board, position, color)
    @board = board
    @position, @color = position, color
  end
  
  def valid_move?(pos)
    return @board.pos_occupied_by?(pos, self.color) ? false : true
  end
  
  def in_bounds?(pos)
    return (pos[0].between?(0, 7) && pos[1].between?(0, 7)) ? true : false
  end

end