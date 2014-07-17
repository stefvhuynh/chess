require_relative "../illegal_move_error"

class Piece
  attr_reader :position, :color
  
  def initialize(board, position, color)
    @board = board
    @position, @color = position, color
  end
  
  def move(pos)
    move_pool = possible_moves
    if move_pool.include?(pos)
    else
      raise
    end
  end
  
  # Will add more to this method (check for in_check? and checkmate?)
  def valid_move?(pos)
    return @board.pos_occupied_by?(pos, self.color) ? false : true
  end
  
  def in_bounds?(pos)
    return (pos[0].between?(0, 7) && pos[1].between?(0, 7)) ? true : false
  end

end


