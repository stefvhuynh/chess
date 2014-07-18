require_relative "../illegal_move_error"

class Piece
  attr_reader :color, :move_history
  attr_accessor :position
  
  def initialize(board, position, color)
    @board = board
    @position, @color = position, color
    @move_history = [position]
  end
  
  def move(new_pos)
    # SteppingPiece#possible_moves and SlidingPiece#possible_moves
    if possible_moves.include?(new_pos)
      @board.taken_pieces << @board[new_pos] if @board.pos_occupied?(new_pos)
      @board[new_pos] = self
      @board[self.position] = nil
      self.position = new_pos
      self.move_history << new_pos
    else
      raise IllegalMoveError
    end
  end

end


