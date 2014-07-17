class IllegalMoveError < StandardError
  def initialize(msg = "IllegalMoveError: move is not legal")
    super
  end
end


