require_relative "../illegal_move_error"

class Piece
  attr_reader :color
  attr_accessor :position, :move_history
  
  def initialize(board, position, color)
    @board = board
    @position, @color = position, color
    @move_history = [position]
    @board[position] = self
  end
  
  def move(new_pos)
    # Subclass#possible_moves (SlidingPiece, SteppingPiece, Pawn)
    if possible_moves.include?(new_pos) #&& safe_move?(new_pos)
      # Also shovel in the nils (empty spaces) for Piece#undo_move
      @board.taken_pieces << @board[new_pos]
      @board[new_pos] = self
      @board[self.position] = nil
      self.position = new_pos
      self.move_history << new_pos
    else
      raise IllegalMoveError
    end
  end
  
  def undo_move
    # Need to pop twice because Piece#move pushes in the current position.
    self.move_history.pop
    prev_pos = self.move_history.pop
    @board[prev_pos] = self
    @board[self.position] = @board.taken_pieces.pop
    self.position = prev_pos
  end
  
  def non_check_move?(move)
    self.move(move)
    bool = @board.in_check?(self.color)
    self.undo_move
    !bool
  end
  
  # def safe_move?(move)
  #   dup_board = @board.dup
  #   dup_board[self.position].move(move)
  #   !dup_board.in_check?(self.color)
  # end
  
  # def dup(board)
  #   dup_piece = self.class.new(board, self.position, self.color)
  #   dup_piece.move_history = self.move_history.dup
  #   dup_piece
  # end

end



