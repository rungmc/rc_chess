# frozen_string_literal: true

# Establishes the chess board, stores all location data.
class Board
  attr_accessor :grid, :history

  def initialize(grid = fresh_board, history = [])
    @grid = grid
    @history = history
  end

  def fresh_board
    # Format: grid[x][y]
    @grid = Array.new(8, Array.new(8))
    place_pawns
    place_rooks
    place_knights
    place_bishops
    place_kings
    place_queens
  end

  def place_pawns
    @grid.each do |row|
      row[1] = Pawn.new('white')
      row[6] = Pawn.new('black')
    end
  end

  def place_rooks
    @grid[0][0] = Rook.new('white')
    @grid[7][0] = Rook.new('white')
    @grid[0][7] = Rook.new('black')
    @grid[7][7] = Rook.new('black')
  end

  def place_knights
    @grid[1][0] = Knight.new('white')
    @grid[6][0] = Knight.new('white')
    @grid[1][7] = Knight.new('black')
    @grid[6][7] = Knight.new('black')
  end

  def place_bishops
    @grid[2][0] = Bishop.new('white')
    @grid[5][0] = Bishop.new('white')
    @grid[2][7] = Bishop.new('black')
    @grid[5][7] = Bishop.new('black')
  end

  def place_kings
    @grid[4][0] = King.new('white')
    @grid[4][7] = King.new('black')
  end

  def place_queens
    @grid[3][0] = Queen.new('white')
    @grid[3][7] = Queen.new('black')
  end

  # Executes a move (no checks for validity) and adds it to the board history.
  def move(piece, start, destination)
    @grid[start[0]][start[1]] = nil
    @grid[destination[0]][destination[1]] = piece
    piece.moved = true

    @history << "#{piece.symbol}#{readable(start)}#{note_capture(destination)}#{readable(dest)}"
  end

  # Translates internally used coordinates to chess notation.
  def readable(coord)
    "#{%w[A B C D E F G H][coord[0]]}#{coord[1] + 1}"
  end

  # Denotes whether or not a capture has occurred by executing a move.
  def note_capture(coord)
    @grid[coord[0]][coord[1]].nil? ? '-' : "x#{@grid[coord[0]][coord[1]].symbol}"
  end
end
