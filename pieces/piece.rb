require_relative "../illegal_move_error"

class Piece
  attr_reader :color
  attr_accessor :position
  
  def initialize(board, position, color)
    @board = board
    @position, @color = position, color
  end
  
  def move(new_pos)
    # SteppingMoves#possible_moves and SlidingMoves#possible_moves
    if possible_moves.include?(new_pos)
      @board[new_pos] = self
      @board[self.position] = nil
      self.position = new_pos
    else
      raise IllegalMoveError
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


