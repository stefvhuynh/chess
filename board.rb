require_relative "pieces/king"
require_relative "pieces/queen"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/rook"
require_relative "pieces/pawn"
require "colorize"

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
  
  # def dup
  #   Board.new(true).tap do |dup_board|
  #     self.each_with_index do |obj, row, col|
  #       dup_board[[row, col]] = obj.dup(dup_board) unless obj.nil?
  #     end
  #   end
  # end
  
  def checkmate?(color)
    self.each do |obj|
      if !obj.nil? && obj.color == color
        return false if obj.possible_moves.any? { |move| obj.safe_move?(move) }
      end
    end
    
    true
  end
  
  def in_check?(color)
    self.each do |obj|
      # Don't need to check for opposing color here because 
      # Piece#possible_moves already excludes one's own color.
      return true if !obj.nil? && obj.possible_moves.include?(king_pos(color))
    end
    
    false
  end
  
  def king_pos(color)
    [].tap do |king_pos|
      self.each_with_index do |obj, row, col|
        king_pos << row << col if obj.class == King && obj.color == color
      end
    end
  end
  
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
    puts render
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
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    self.each_index do |row, col|
      if row == 0
        back_row[col].new(self, [row, col], :black)
      elsif row == 7
        back_row[col].new(self, [row, col], :white)
      elsif row == 1
        Pawn.new(self, [row, col], :black)
      elsif row == 6
        Pawn.new(self, [row, col], :white)
      end
    end
  end
  
  # def populate_board
  #   back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  #   self.each_index do |row, col|
  #     if row == 0
  #       self[[row, col]] = back_row[col].new(self, [row, col], :black)
  #     elsif row == 7
  #       self[[row, col]] = back_row[col].new(self, [row, col], :white)
  #     elsif row == 1
  #       self[[row, col]] = Pawn.new(self, [row, col], :black)
  #     elsif row == 6
  #       self[[row, col]] = Pawn.new(self, [row, col], :white)
  #     end
  #   end
  # end

  def render
    rendered = "   A  B  C  D  E  F  G  H\n"
    self.each_with_index do |obj, row, col|
      rendered += "#{8 - row} " if col == 0
      
      if (row + col).odd?
        if obj.nil?
          rendered += "   ".colorize(:background => :white)
        else
          rendered += obj.render.colorize(:background => :white)
        end
      else
        if obj.nil?
          rendered += "   "
        else
          rendered += obj.render
        end
      end
      
      rendered += "\n" if col == 7
    end
    
    rendered
  end

end

b = Board.new(true)
King.new(b, [0, 0], :black)
Bishop.new(b, [1, 0], :black)
Rook.new(b, [7, 0], :white)
b.display
p b[[1, 0]].non_check_move?([2, 1])


