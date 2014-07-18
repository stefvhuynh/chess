require_relative "pieces/king"
require_relative "pieces/queen"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/rook"
require_relative "pieces/pawn"

class Board
  
  def self.create_grid
    Array.new(8) { Array.new(8) }
  end
  
  attr_reader :taken_pieces
  
  def initialize(blank = false)
    @grid = self.class.create_grid
    @taken_pieces = []
    populate_board if !blank
  end
  
  def [](pos)
    row, col = pos
    @grid[row][col]
  end
  
  def []=(pos, obj)
    row, col = pos
    @grid[row][col] = obj
  end
  
  def checkmate?
  end
  
  def in_check?
  end
  
  # Will add more to this method (check for in_check? and checkmate?)
  def valid_move?(pos, color)
    in_bounds?(pos) && (pos_empty?(pos) || self[pos].color != color)
  end
  
  def in_bounds?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end
  
  def pos_empty?(pos)
    self[pos].nil?
  end
  
  def display
  end
  
  def each_index(&blk)
    8.times do |row|
      8.times { |col| blk.call(row, col) }
    end
    
    @grid
  end
  
  def each(&blk)
    @grid.each do |row|
      row.each { |obj| blk.call(obj) }
    end
  end
  
  def each_with_index(&blk)
    @grid.each_with_index do |row, row_i|
      row.each_with_index { |obj, col_i| blk.call(obj, row_i, col_i) }
    end
  end
  
  private
  
  def populate_board
  end

  def render
  end

end

b = Board.new
q = Queen.new(b, [0, 0], :white)
b[[0, 0]] = q
k = King.new(b, [2, 2], :white)
b[[2, 2]] = k
p q.possible_moves

q.move([3, 3])
p b






