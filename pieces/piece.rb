require_relative "../illegal_move_error"

class Piece
  attr_reader :color
  attr_accessor :position
  
  def initialize(board, position, color)
    @board = board
    @position, @color = position, color
  end
  
  def move(new_pos)
    # SteppingPieces#possible_moves and SlidingPieces#possible_moves
    if possible_moves.include?(new_pos)
      # Don't need to check the color, because #possible_moves already takes
      # care of that. Simply stash away the piece if there was one, reassign
      # the board's piece placement, empty the pieces prior position and 
      # reassign the piece's position attribute.
      @board.taken_pieces << @board[new_pos] if @board.pos_occupied?(new_pos)
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


